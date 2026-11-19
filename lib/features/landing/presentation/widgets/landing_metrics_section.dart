import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class LandingMetricsSection extends StatelessWidget {
  const LandingMetricsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0F172A),
      padding: EdgeInsets.symmetric(
        vertical: context.isMobile ? 32 : 48,
        horizontal: 24,
      ),
      child: ResponsiveContainer(
        child: Wrap(
          spacing: 32,
          runSpacing: 24,
          alignment: WrapAlignment.spaceAround,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: const [
            _MetricItem(
              value: '50,000+',
              label: 'Tasks Deconstructed',
              subtitle: 'From complex code to study syllabi',
            ),
            _MetricItem(
              value: '94%',
              label: 'Reduced Overwhelm',
              subtitle: 'Reported by active users',
            ),
            _MetricItem(
              value: '3.2x',
              label: 'Faster Execution',
              subtitle: 'Average time to first action',
            ),
            _MetricItem(
              value: '4.9 / 5',
              label: 'User Rating',
              subtitle: 'Across web and mobile',
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String value;
  final String label;
  final String subtitle;

  const _MetricItem({
    required this.value,
    required this.label,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF34D399), Color(0xFF60A5FA)],
            ).createShader(bounds),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -1,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}
