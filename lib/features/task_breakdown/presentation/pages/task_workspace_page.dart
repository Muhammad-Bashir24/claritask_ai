import 'package:claritask_ai/core/utils/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../cubit/task_breakdown_cubit.dart';
import '../cubit/task_breakdown_state.dart';
import '../widgets/task_step_card.dart';

class TaskWorkspacePage extends StatefulWidget {
  final String taskId;
  final String taskTitle;

  const TaskWorkspacePage({
    super.key,
    required this.taskId,
    required this.taskTitle,
  });

  @override
  State<TaskWorkspacePage> createState() => _TaskWorkspacePageState();
}

class _TaskWorkspacePageState extends State<TaskWorkspacePage> {
  late TaskBreakdownCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = sl<TaskBreakdownCubit>();
    _cubit.loadOrBreakdownTask(widget.taskId);
  }

  @override
  void dispose() {
    _cubit.reset(); // Optionally close or reset
    super.dispose();
  }

  Widget _buildLoadingState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.primary.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.smart_toy_rounded,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Text(
              'Understanding your task...',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'ClariTask AI is generating your optimized workflow',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                minHeight: 4,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.auto_awesome, size: 16, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Quantum-processing active',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            TextButton.icon(
              onPressed: () => context.pop(),
              icon: Icon(Icons.close, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
              label: Text(
                'Cancel processing',
                style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocProvider.value(
      value: _cubit,
      child: BlocListener<TaskBreakdownCubit, TaskBreakdownState>(
        listener: (context, state) {
          if (state is TaskBreakdownSuccess) {
            CustomToast.show(
              context: context,
              message: 'Task generated successfully!',
              type: ToastType.success,
            );
          }
        },
        child: Scaffold(
          backgroundColor: theme.colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: theme.colorScheme.onSurface),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'ClariTask AI',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<TaskBreakdownCubit, TaskBreakdownState>(
            builder: (context, state) {
              if (state is TaskBreakdownLoading || state is TaskBreakdownInitial) {
                return _buildLoadingState(context);
              }

              if (state is TaskBreakdownError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Couldn't break this task down right now.",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: TextStyle(color: Colors.grey[600]),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () => _cubit.retryBreakdown(widget.taskId),
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (state is TaskBreakdownSuccess) {
                final steps = state.steps;
                if (steps.isEmpty) {
                  return const Center(child: Text('No steps found.'));
                }

                int completedCount = steps.where((s) => s.isCompleted).length;
                int totalCount = steps.length;
                double progress = totalCount > 0 ? completedCount / totalCount : 0;

                return Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CURRENT PROGRESS',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.taskTitle,
                                        style: theme.textTheme.headlineSmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          height: 1.2,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      '${(progress * 100).toInt()}%',
                                      style: theme.textTheme.headlineSmall?.copyWith(
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: theme.colorScheme.outline.withValues(alpha: 0.1),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.description_outlined, size: 16, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Original Request',
                                            style: theme.textTheme.labelMedium?.copyWith(
                                              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        '"${widget.taskTitle}"',
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          fontStyle: FontStyle.italic,
                                          color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 32),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'AI GENERATED STEPS',
                                      style: theme.textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.1,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '$totalCount Steps',
                                        style: theme.textTheme.labelSmall?.copyWith(
                                          color: theme.colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return TaskStepCard(
                                  step: steps[index],
                                  onToggle: (updatedStep) {
                                    _cubit.toggleStepCompletion(updatedStep);
                                  },
                                );
                              },
                              childCount: steps.length,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0).copyWith(bottom: 100),
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // TODO: Add custom step functionality
                              },
                              icon: const Icon(Icons.add_circle_outline),
                              label: const Text('Add custom step'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                side: BorderSide(
                                  color: theme.colorScheme.outline.withValues(alpha: 0.3),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 24,
                      left: 24,
                      right: 24,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: theme.colorScheme.primary.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'You\'re doing great, one step at a time',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.emoji_emotions_outlined, size: 16, color: theme.colorScheme.primary),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
