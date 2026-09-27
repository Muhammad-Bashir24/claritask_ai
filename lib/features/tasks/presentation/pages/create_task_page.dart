import 'package:claritask_ai/core/di/injection.dart';
import 'package:claritask_ai/features/tasks/presentation/cubit/create_task_cubit.dart';
import 'package:claritask_ai/features/tasks/presentation/cubit/create_task_state.dart';
import 'package:claritask_ai/core/utils/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateTaskPage extends StatelessWidget {
  final String primaryUsage;

  const CreateTaskPage({super.key, required this.primaryUsage});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CreateTaskCubit>(),
      child: _CreateTaskView(primaryUsage: primaryUsage),
    );
  }
}

class _CreateTaskView extends StatefulWidget {
  final String primaryUsage;

  const _CreateTaskView({required this.primaryUsage});

  @override
  State<_CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<_CreateTaskView> {
  late final TextEditingController _controller;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      final text = _controller.text.trim();
      setState(() {
        _isButtonEnabled = text.isNotEmpty;
      });
      if (text.isNotEmpty) {
        context.read<CreateTaskCubit>().clearError();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getHintText() {
    switch (widget.primaryUsage) {
      case 'tech_coding':
        return 'e.g. I want to build a Flutter food delivery app';
      case 'cooking_home':
        return 'e.g. I want to cook jollof rice for 10 people';
      case 'school_study':
        return 'e.g. I need to prepare for my mathematics exam';
      case 'business_startup':
        return 'e.g. I want to launch my online store';
      case 'work_professional':
        return 'e.g. I need to prepare a presentation for Monday';
      case 'creative_content':
        return 'e.g. I want to create a YouTube video';
      case 'learning_skills':
        return 'e.g. I want to learn Flutter animations';
      case 'personal_tasks':
        return 'e.g. I want to organize my bedroom';
      default:
        return 'e.g. I want to build a food delivery app';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: theme.colorScheme.onSurface,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<CreateTaskCubit, CreateTaskState>(
        listener: (context, state) {
          if (state is CreateTaskSuccess) {
            // We removed the toast here because it will navigate instantly and the success is handled on the next screen if needed,
            // or we can show it here:
            CustomToast.show(
              context: context,
              message: 'Task created successfully!',
              type: ToastType.success,
            );
            context.pushReplacementNamed(
              'task-workspace',
              extra: {'taskId': state.task.id, 'taskTitle': state.task.title},
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is CreateTaskLoading;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What do you need to get done?',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tell ClariTaskAI what you\'re trying to accomplish.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: state is CreateTaskError
                              ? theme.colorScheme.error
                              : theme.colorScheme.outline.withValues(
                                  alpha: 0.2,
                                ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.shadow.withValues(
                              alpha: 0.05,
                            ),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              maxLines: null,
                              expands: true,
                              textAlignVertical: TextAlignVertical.top,
                              maxLength: 500,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(500),
                              ],
                              decoration: InputDecoration(
                                hintText: _getHintText(),
                                hintStyle: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.4,
                                  ),
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(24),
                                counterText:
                                    '', // Hide default counter, let the textfield handle it if needed
                              ),
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '\${_controller.text.length}/500',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (state is CreateTaskError)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        state.message,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: (_isButtonEnabled && !isLoading)
                          ? () {
                              FocusScope.of(context).unfocus();
                              context.read<CreateTaskCubit>().createTask(
                                _controller.text,
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        disabledBackgroundColor: theme.colorScheme.primary
                            .withValues(alpha: 0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: isLoading
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: theme.colorScheme.onPrimary,
                              ),
                            )
                          : const Text(
                              'Create Task',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
