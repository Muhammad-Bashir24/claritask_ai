import 'package:claritask_ai/core/di/injection.dart';
import 'package:claritask_ai/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:claritask_ai/features/home/presentation/cubit/home_cubit.dart';
import 'package:claritask_ai/features/personalization/domain/entities/personalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>()..fetchHomeData(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            context.go('/auth');
          }
        },
        child: const _HomeScreenContent(),
      ),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return const _HomeSkeleton();
            } else if (state is HomeError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: theme.colorScheme.error,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Couldn't load your personalized experience.",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          context.read<HomeCubit>().fetchHomeData();
                        },
                        child: const Text('Try again'),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is HomeLoaded) {
              return _buildPersonalizedContent(
                context,
                state.personalization,
                theme,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildPersonalizedContent(
    BuildContext context,
    PersonalizationEntity personalization,
    ThemeData theme,
  ) {
    final authState = context.read<AuthCubit>().state;
    String firstName = '';
    String? avatarUrl;

    if (authState is AuthAuthenticated) {
      final nameParts = authState.user.fullName?.split(' ') ?? [];
      if (nameParts.isNotEmpty) {
        firstName = nameParts.first;
      }
      avatarUrl = authState.user.avatarUrl;
    }

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<HomeCubit>().fetchHomeData();
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, firstName, avatarUrl, theme),
                  const SizedBox(height: 40),
                  _buildPersonalizedGreeting(
                    personalization.primaryUsage,
                    theme,
                  ),
                  const SizedBox(height: 12),
                  _buildChallengeMessage(
                    personalization.biggestChallenge,
                    theme,
                  ),
                  const SizedBox(height: 40),
                  _buildMainTaskInput(personalization.primaryUsage, theme),
                  const SizedBox(height: 48),
                  _buildSuggestionsSection(personalization.primaryUsage, theme),
                  const SizedBox(height: 48),
                  _buildRecentTasksSection(theme),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    String firstName,
    String? avatarUrl,
    ThemeData theme,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 22,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
                    ? NetworkImage(avatarUrl)
                    : null,
                child: (avatarUrl == null || avatarUrl.isEmpty)
                    ? Icon(
                        Icons.person,
                        color: theme.colorScheme.onSurfaceVariant,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              firstName.isNotEmpty ? 'Hey, $firstName' : 'Welcome back',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.logout_rounded,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          onPressed: () => context.read<AuthCubit>().logout(),
        ),
      ],
    );
  }

  Widget _buildPersonalizedGreeting(String primaryUsage, ThemeData theme) {
    String greeting;
    switch (primaryUsage) {
      case 'tech_coding':
        greeting = 'Ready to build\nsomething amazing?';
        break;
      case 'cooking_home':
        greeting = 'What are we\ncooking up today?';
        break;
      case 'school_study':
        greeting = 'Ready to ace\nyour next study session?';
        break;
      case 'work_professional':
        greeting = "Let's conquer\ntoday's work.";
        break;
      case 'business_startup':
        greeting = 'What are we\nbuilding today?';
        break;
      case 'creative_content':
        greeting = 'Ready to bring\nyour ideas to life?';
        break;
      case 'personal_tasks':
      default:
        greeting = 'What do you want\nto get done today?';
        break;
    }

    return Text(
      greeting,
      style: theme.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w800,
        height: 1.2,
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildChallengeMessage(String biggestChallenge, ThemeData theme) {
    String message;
    switch (biggestChallenge) {
      case 'dont_know_where_to_start':
        message = "Not sure where to start? We'll break it down.";
        break;
      case 'tasks_feel_overwhelming':
        message = "Feeling overwhelmed? Take it one step at a time.";
        break;
      case 'need_task_broken_into_steps':
        message = "Give us the task. We'll make it simple.";
        break;
      case 'want_more_consistency':
        message = "Keep moving forward, one simple step at a time.";
        break;
      case 'need_more_structure':
        message = "Let's give your task the structure it needs.";
        break;
      case 'want_faster_execution':
        message = "Turn your task into clear actions and execute.";
        break;
      case 'need_help_learning':
        message = "Tell us what you're learning, we'll guide you.";
        break;
      default:
        message = "Tell ClariTaskAI what you need to accomplish.";
    }

    return Text(
      message,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        height: 1.5,
      ),
    );
  }

  Widget _buildMainTaskInput(String primaryUsage, ThemeData theme) {
    String hintText;
    switch (primaryUsage) {
      case 'tech_coding':
        hintText = 'e.g. Build a login screen in Flutter...';
        break;
      case 'school_study':
        hintText = 'e.g. Study for my biology midterm...';
        break;
      case 'cooking_home':
        hintText = 'e.g. Meal prep for the week...';
        break;
      case 'work_professional':
        hintText = 'e.g. Prepare the Q3 marketing report...';
        break;
      default:
        hintText = 'e.g. Organize my home office...';
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: TextField(
        maxLines: 4,
        minLines: 1,
        style: theme.textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: theme.colorScheme.surface,
          contentPadding: const EdgeInsets.all(24),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.mic_rounded, color: theme.colorScheme.primary),
                onPressed: () {
                  // TODO: Voice input implementation
                },
              ),
            ),
          ),
        ),
        onSubmitted: (value) {
          // TODO: Navigate to create task flow
        },
      ),
    );
  }

  Widget _buildSuggestionsSection(String primaryUsage, ThemeData theme) {
    List<String> suggestions;
    switch (primaryUsage) {
      case 'tech_coding':
        suggestions = [
          'Break down a project',
          'Plan dev tasks',
          'Learn a skill',
        ];
        break;
      case 'school_study':
        suggestions = [
          'Break down study task',
          'Plan assignment',
          'Create study plan',
        ];
        break;
      case 'cooking_home':
        suggestions = [
          'Break down a recipe',
          'Plan cooking',
          'Organize kitchen',
        ];
        break;
      case 'business_startup':
        suggestions = [
          'Break down business task',
          'Plan next step',
          'Organize priorities',
        ];
        break;
      case 'creative_content':
        suggestions = ['Break down project', 'Plan content', 'Organize ideas'];
        break;
      case 'work_professional':
        suggestions = [
          'Break down work task',
          'Plan today',
          'Organize priorities',
        ];
        break;
      case 'learning_skills':
        suggestions = [
          'Break down learning',
          'Create a task',
          'Plan next step',
        ];
        break;
      case 'personal_tasks':
      default:
        suggestions = ['Break down a task', 'Organize day', 'Plan what to do'];
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Suggested for you',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: suggestions.map((suggestion) {
            return InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.1),
                  ),
                ),
                child: Text(
                  suggestion,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecentTasksSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your active tasks',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  size: 40,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'You\'re all caught up!',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Ready to tackle something new? Tell us what you need to get done above.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HomeSkeleton extends StatefulWidget {
  const _HomeSkeleton();

  @override
  State<_HomeSkeleton> createState() => _HomeSkeletonState();
}

class _HomeSkeletonState extends State<_HomeSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final skeletonColor = theme.colorScheme.surfaceContainerHighest.withValues(
      alpha: 0.5,
    );
    final borderRadius = BorderRadius.circular(16);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(opacity: 0.5 + (_controller.value * 0.5), child: child);
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header skeleton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: skeletonColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 120,
                      height: 24,
                      decoration: BoxDecoration(
                        color: skeletonColor,
                        borderRadius: borderRadius,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: skeletonColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Greeting skeleton
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                color: skeletonColor,
                borderRadius: borderRadius,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 180,
              height: 40,
              decoration: BoxDecoration(
                color: skeletonColor,
                borderRadius: borderRadius,
              ),
            ),
            const SizedBox(height: 16),

            // Challenge message skeleton
            Container(
              width: double.infinity,
              height: 16,
              decoration: BoxDecoration(
                color: skeletonColor,
                borderRadius: borderRadius,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 200,
              height: 16,
              decoration: BoxDecoration(
                color: skeletonColor,
                borderRadius: borderRadius,
              ),
            ),
            const SizedBox(height: 40),

            // Input skeleton
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: skeletonColor,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            const SizedBox(height: 48),

            // Suggestions skeleton
            Container(
              width: 140,
              height: 24,
              decoration: BoxDecoration(
                color: skeletonColor,
                borderRadius: borderRadius,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(
                3,
                (index) => Container(
                  width: 100 + (index * 20.0),
                  height: 44,
                  decoration: BoxDecoration(
                    color: skeletonColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),

            // Active task skeleton
            Container(
              width: 140,
              height: 24,
              decoration: BoxDecoration(
                color: skeletonColor,
                borderRadius: borderRadius,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: skeletonColor,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
