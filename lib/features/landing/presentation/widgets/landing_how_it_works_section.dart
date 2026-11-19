import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class LandingHowItWorksSection extends StatelessWidget {
  const LandingHowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 20 : 32,
        vertical: 64,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'SIMPLE THREE-STEP FLOW',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF059669),
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'From Overwhelmed to In-Flow in 10 Seconds',
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
            constraints: const BoxConstraints(maxWidth: 600),
            child: const Text(
              'No elaborate configuration or complicated hierarchies. Just raw input transformed into frictionless action.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF64748B),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 48),

          // 3 Steps
          if (context.isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _StepCard(
                    number: '01',
                    icon: Icons.edit_note_rounded,
                    title: 'Type Your Big Goal',
                    description:
                        'Speak or write whatever you are dreading: "Build a Flutter web landing page" or "Clean the entire garage".',
                  ),
                ),
                _buildConnectingArrow(),
                Expanded(
                  child: _StepCard(
                    number: '02',
                    icon: Icons.auto_awesome_rounded,
                    title: 'AI Synthesizes Path',
                    description:
                        'Our cognitive engine estimates times, determines dependency order, and structures 3 to 7 achievable micro-steps.',
                  ),
                ),
                _buildConnectingArrow(),
                Expanded(
                  child: _StepCard(
                    number: '03',
                    icon: Icons.check_circle_rounded,
                    title: 'Crush Micro-Actions',
                    description:
                        'Check off one manageable step at a time. Watch your progress bar advance and enjoy unstoppable dopamine momentum.',
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                _StepCard(
                  number: '01',
                  icon: Icons.edit_note_rounded,
                  title: 'Type Your Big Goal',
                  description:
                      'Speak or write whatever you are dreading: "Build a Flutter web landing page" or "Clean the entire garage".',
                ),
                const SizedBox(height: 24),
                _StepCard(
                  number: '02',
                  icon: Icons.auto_awesome_rounded,
                  title: 'AI Synthesizes Path',
                  description:
                      'Our cognitive engine estimates times, determines dependency order, and structures 3 to 7 achievable micro-steps.',
                ),
                const SizedBox(height: 24),
                _StepCard(
                  number: '03',
                  icon: Icons.check_circle_rounded,
                  title: 'Crush Micro-Actions',
                  description:
                      'Check off one manageable step at a time. Watch your progress bar advance and enjoy unstoppable dopamine momentum.',
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildConnectingArrow() {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 12, right: 12),
      child: Icon(
        Icons.east_rounded,
        color: const Color(0xFFCBD5E1),
        size: 24,
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final String number;
  final IconData icon;
  final String title;
  final String description;

  const _StepCard({
    required this.number,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              Text(
                number,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0F172A).withValues(alpha: 0.15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
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
