import 'package:claritask_ai/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LandingHeroSection extends StatefulWidget {
  final VoidCallback onSeeHowItWorksTap;

  const LandingHeroSection({
    super.key,
    required this.onSeeHowItWorksTap,
  });

  @override
  State<LandingHeroSection> createState() => _LandingHeroSectionState();
}

class _LandingHeroSectionState extends State<LandingHeroSection> {
  // 8 steps from Section 5 of the Product Brief
  final List<_HeroStepItem> _steps = [
    _HeroStepItem(
      title: 'Decide what sections your portfolio should contain.',
      isCompleted: true,
    ),
    _HeroStepItem(
      title: 'Choose the technologies you want to use.',
      isCompleted: true,
    ),
    _HeroStepItem(
      title: 'Create a new project.',
      isCompleted: true,
    ),
    _HeroStepItem(
      title: 'Set up the project structure.',
      isCompleted: false,
    ),
    _HeroStepItem(
      title: 'Design the homepage.',
      isCompleted: false,
    ),
    _HeroStepItem(
      title: 'Add your projects and professional information.',
      isCompleted: false,
    ),
    _HeroStepItem(
      title: 'Test the website on different screen sizes.',
      isCompleted: false,
    ),
    _HeroStepItem(
      title: 'Deploy your portfolio.',
      isCompleted: false,
    ),
  ];

  int get _completedCount => _steps.where((s) => s.isCompleted).length;
  double get _progress => _steps.isEmpty ? 0 : _completedCount / _steps.length;

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final isAuthenticated = authState is AuthAuthenticated;

    return ResponsiveContainer(
      maxWidth: 1100,
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 20 : 32,
        vertical: context.isMobile ? 36 : 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Trust / Category Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'AI-Powered Task Breakdown & Execution Assistant',
                  style: TextStyle(
                    fontSize: context.isMobile ? 12 : 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Main Headline (from Brief Section 8 & 10)
          Text(
            'Turn any task into simple steps.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.isMobile ? 32 : (context.isTablet ? 46 : 56),
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0F172A),
              height: 1.15,
              letterSpacing: -1.2,
            ),
          ),
          const SizedBox(height: 20),

          // Supporting Description (from Brief Section 8 & 10)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              'Tell ClariTaskAI what you need to get done. Get a clear, practical breakdown and take it one step at a time.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.isMobile ? 16 : 18,
                color: const Color(0xFF475569),
                height: 1.55,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // CTA Buttons
          Wrap(
            spacing: 16,
            runSpacing: 14,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (isAuthenticated) {
                    context.go('/home');
                  } else {
                    context.push('/auth');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F172A),
                  foregroundColor: Colors.white,
                  minimumSize: Size.zero,
                  padding: EdgeInsets.symmetric(
                    horizontal: context.isMobile ? 24 : 32,
                    vertical: context.isMobile ? 14 : 18,
                  ),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isAuthenticated ? 'Go to Dashboard' : 'Get Started',
                      style: TextStyle(
                        fontSize: context.isMobile ? 15 : 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 18),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: widget.onSeeHowItWorksTap,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0F172A),
                  side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.isMobile ? 20 : 28,
                    vertical: context.isMobile ? 14 : 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.play_circle_outline_rounded, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'See How It Works',
                      style: TextStyle(
                        fontSize: context.isMobile ? 15 : 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),

          // Hero Visual: Realistic ClariTaskAI Application Mockup
          _buildHeroWorkspaceMockup(context),
        ],
      ),
    );
  }

  Widget _buildHeroWorkspaceMockup(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.08),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Window Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              color: const Color(0xFFF8FAFC),
              child: Row(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEF4444),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF59E0B),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFF10B981),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.splitscreen_rounded,
                        size: 16,
                        color: Color(0xFF64748B),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'ClariTask Workspace Preview',
                        style: TextStyle(
                          fontSize: context.isMobile ? 12 : 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE2E8F0)),

            // Mockup Workspace Body
            Padding(
              padding: EdgeInsets.all(context.isMobile ? 16 : 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Task Input Display
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.edit_note_rounded,
                              size: 18,
                              color: Color(0xFF2563EB),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Task Described:',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCFCE7),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'AI Breakdown Ready',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF15803D),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '"I want to build a personal portfolio website."',
                          style: TextStyle(
                            fontSize: context.isMobile ? 15 : 17,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Progress & Completion Meter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Actionable Steps ($_completedCount of ${_steps.length} completed)',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        '${(_progress * 100).toInt()}% Done',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 300),
                      tween: Tween<double>(begin: 0, end: _progress),
                      builder: (context, value, child) {
                        return LinearProgressIndicator(
                          value: value,
                          minHeight: 8,
                          backgroundColor: const Color(0xFFE2E8F0),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF2563EB),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Interactive Steps List (The 8 Steps from Section 5 of Brief)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _steps.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final step = _steps[index];
                      return Material(
                        color: step.isCompleted
                            ? const Color(0xFFF8FAFC)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: step.isCompleted
                                ? const Color(0xFFE2E8F0)
                                : const Color(0xFFCBD5E1),
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            setState(() {
                              step.isCompleted = !step.isCompleted;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  step.isCompleted
                                      ? Icons.check_circle_rounded
                                      : Icons.radio_button_unchecked_rounded,
                                  color: step.isCompleted
                                      ? const Color(0xFF10B981)
                                      : const Color(0xFF94A3B8),
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '${index + 1}.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: step.isCompleted
                                        ? const Color(0xFF94A3B8)
                                        : const Color(0xFF64748B),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    step.title,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: step.isCompleted
                                          ? FontWeight.w500
                                          : FontWeight.w600,
                                      color: step.isCompleted
                                          ? const Color(0xFF94A3B8)
                                          : const Color(0xFF1E293B),
                                      decoration: step.isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroStepItem {
  final String title;
  bool isCompleted;

  _HeroStepItem({
    required this.title,
    this.isCompleted = false,
  });
}
