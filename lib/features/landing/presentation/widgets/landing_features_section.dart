import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class LandingFeaturesSection extends StatelessWidget {
  const LandingFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // The exact 7 features from Section 6 of the Product Brief
    final features = [
      _FeatureData(
        icon: Icons.auto_awesome_rounded,
        title: 'AI Task Breakdown',
        description:
            'Convert any task or goal into simple, actionable steps that take you from start to finish.',
      ),
      _FeatureData(
        icon: Icons.folder_outlined,
        title: 'Task Management',
        description:
            'Create, organize, and save your personal tasks in one clean, distraction-free environment.',
      ),
      _FeatureData(
        icon: Icons.view_timeline_outlined,
        title: 'Task Workspace',
        description:
            'View the full breakdown for each task with clear step titles and practical explanations.',
      ),
      _FeatureData(
        icon: Icons.check_circle_outline_rounded,
        title: 'Step Completion',
        description:
            'Mark individual steps as completed as you work, keeping you locked in on the next practical action.',
      ),
      _FeatureData(
        icon: Icons.trending_up_rounded,
        title: 'Progress Tracking',
        description:
            'See visual completion percentages and progress bars update in real time with each step you finish.',
      ),
      _FeatureData(
        icon: Icons.history_rounded,
        title: 'Task History',
        description:
            'Access all previously created tasks to review past breakdowns, pick up where you left off, or check completed work.',
      ),
      _FeatureData(
        icon: Icons.mic_none_rounded,
        title: 'Voice Task Input',
        description:
            'Describe tasks using your voice as an alternative to typing, turning spoken thoughts directly into structured steps.',
      ),
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
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
                'CORE MVP FEATURES',
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
              'Everything You Need to Take Action',
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
                'Focused exclusively on task breakdown and execution. No unnecessary bloat or complex configuration.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 48),

            // Features Grid
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
                  children: features.map((f) {
                    return SizedBox(
                      width: itemWidth,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: Icon(
                                f.icon,
                                size: 20,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              f.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              f.description,
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

class _FeatureData {
  final IconData icon;
  final String title;
  final String description;

  _FeatureData({
    required this.icon,
    required this.title,
    required this.description,
  });
}
