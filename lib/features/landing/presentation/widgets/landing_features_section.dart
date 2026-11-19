import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class LandingFeaturesSection extends StatelessWidget {
  const LandingFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAFC),
      padding: EdgeInsets.symmetric(
        vertical: context.isMobile ? 48 : 72,
        horizontal: 20,
      ),
      child: ResponsiveContainer(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF243B6B).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'CORE CAPABILITIES',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF243B6B),
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Engineered for Peak Cognitive Output',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.isMobile ? 24 : 34,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: const Text(
                'Everything you need to move smoothly from ambiguous ideas to completed milestones.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 48),

            // Responsive 2 or 3-column feature grid
            LayoutBuilder(
              builder: (context, constraints) {
                int columns = constraints.maxWidth > 950
                    ? 3
                    : (constraints.maxWidth > 620 ? 2 : 1);
                double spacing = 24;
                double itemWidth =
                    (constraints.maxWidth - (spacing * (columns - 1))) /
                        columns;

                final features = [
                  _FeatureData(
                    icon: Icons.psychology_rounded,
                    color: const Color(0xFF6366F1),
                    title: 'Cognitive Task Breakdown',
                    description:
                        'State your ambition in everyday language. ClariTask AI parses objectives, context, and dependencies into sequential micro-actions.',
                  ),
                  _FeatureData(
                    icon: Icons.bolt_rounded,
                    color: const Color(0xFF10B981),
                    title: 'Zero-Paralysis Focus',
                    description:
                        'Overcome mental resistance by highlighting only the immediate step in front of you. Build momentum with each quick victory.',
                  ),
                  _FeatureData(
                    icon: Icons.tune_rounded,
                    color: const Color(0xFFF59E0B),
                    title: 'Context Personalization',
                    description:
                        'Customized breakdowns tailored specifically for coding projects, academic study, business launches, or creative content.',
                  ),
                  _FeatureData(
                    icon: Icons.checklist_rtl_rounded,
                    color: const Color(0xFF3B82F6),
                    title: 'Dynamic Workspace',
                    description:
                        'Toggle steps, monitor real-time completion percentages, add custom sub-steps, and regenerate paths when plans change.',
                  ),
                  _FeatureData(
                    icon: Icons.mic_rounded,
                    color: const Color(0xFFEC4899),
                    title: 'Natural & Audio Input',
                    description:
                        'Dump raw stream-of-consciousness thoughts through text or voice. Let our intelligence organize the chaos into priority order.',
                  ),
                  _FeatureData(
                    icon: Icons.cloud_sync_rounded,
                    color: const Color(0xFF14B8A6),
                    title: 'Cross-Platform Web & Cloud',
                    description:
                        'Access your tasks seamlessly in your desktop browser or on mobile with Supabase auth and persistent cloud synchronization.',
                  ),
                ];

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: features.map((feature) {
                    return SizedBox(
                      width: itemWidth,
                      child: _FeatureCard(feature: feature),
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
  final Color color;
  final String title;
  final String description;

  _FeatureData({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
  });
}

class _FeatureCard extends StatelessWidget {
  final _FeatureData feature;

  const _FeatureCard({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: feature.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              feature.icon,
              color: feature.color,
              size: 26,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            feature.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            feature.description,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
