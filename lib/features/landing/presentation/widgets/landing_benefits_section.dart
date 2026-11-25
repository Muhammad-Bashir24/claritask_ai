import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class LandingBenefitsSection extends StatelessWidget {
  const LandingBenefitsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // The 6 exact practical benefits from Section 7 & 10 of the Product Brief
    final benefits = [
      _BenefitItem(
        icon: Icons.flag_outlined,
        title: 'Know where to start',
        description:
            'Eliminate hesitation and procrastination. ClariTaskAI pinpoints the very first practical step so you can start right away.',
      ),
      _BenefitItem(
        icon: Icons.layers_outlined,
        title: 'Make overwhelming tasks easier to approach',
        description:
            'Large, intimidating projects become manageable when broken into small, achievable micro-actions.',
      ),
      _BenefitItem(
        icon: Icons.checklist_rtl_rounded,
        title: 'Get clear, actionable instructions',
        description:
            'Receive concrete steps you can actually execute, not vague summaries or generic motivational advice.',
      ),
      _BenefitItem(
        icon: Icons.filter_center_focus_rounded,
        title: 'Stay focused on the next action',
        description:
            'Work through your task one step at a time without cognitive overload or worrying about future steps.',
      ),
      _BenefitItem(
        icon: Icons.trending_up_rounded,
        title: 'See your progress as you work',
        description:
            'Interactive checkboxes and live progress tracking give you tangible proof of momentum at every step.',
      ),
      _BenefitItem(
        icon: Icons.task_alt_rounded,
        title: 'Finish tasks with greater clarity',
        description:
            'Reach completion without feeling stressed or disordered, knowing every required action was addressed.',
      ),
    ];

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAFC),
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 20 : 32,
        vertical: context.isMobile ? 48 : 80,
      ),
      child: ResponsiveContainer(
        maxWidth: 1080,
        child: Column(
          children: [
            // Section Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'PRACTICAL BENEFITS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Headline
            Text(
              'Why Clarity Changes How You Work',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.isMobile ? 26 : 36,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
                letterSpacing: -0.6,
              ),
            ),
            const SizedBox(height: 12),

            // Subtitle
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: const Text(
                'Real productivity comes from knowing exactly what to do next. ClariTaskAI provides the structure you need to get things done.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 48),

            // 6 Benefits Grid
            LayoutBuilder(
              builder: (context, constraints) {
                int columns = constraints.maxWidth > 950
                    ? 3
                    : (constraints.maxWidth > 620 ? 2 : 1);
                double spacing = 20;
                double itemWidth =
                    (constraints.maxWidth - (spacing * (columns - 1))) /
                        columns;

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: benefits.map((b) {
                    return SizedBox(
                      width: itemWidth,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                b.icon,
                                size: 20,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text(
                              b.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              b.description,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF64748B),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BenefitItem {
  final IconData icon;
  final String title;
  final String description;

  _BenefitItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}
