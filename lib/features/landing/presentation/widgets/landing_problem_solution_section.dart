import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class LandingProblemSolutionSection extends StatelessWidget {
  const LandingProblemSolutionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 20 : 32,
        vertical: 48,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'THE CLARITASK ADVANTAGE',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4F46E5),
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Why Traditional To-Do Lists Fail You',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.isMobile ? 24 : 32,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: const Text(
              'Most task managers are passive buckets for anxiety. ClariTask AI actively breaks down cognitive friction into actionable clarity.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF64748B),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Side-by-side or stacked comparison
          if (context.isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildProblemCard()),
                const SizedBox(width: 28),
                Expanded(child: _buildSolutionCard()),
              ],
            )
          else ...[
            _buildProblemCard(),
            const SizedBox(height: 24),
            _buildSolutionCard(),
          ],
        ],
      ),
    );
  }

  Widget _buildProblemCard() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFFED7D7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFFFEE2E2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: Color(0xFFDC2626),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Traditional To-Do Lists',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF991B1B),
                    ),
                  ),
                  Text(
                    'Passive dumps that increase dread',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFB91C1C),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildItem(
            Icons.sentiment_dissatisfied_outlined,
            'Vague Giant Bullets',
            'Items like "Build website" or "Study for finals" leave you paralyzed on where to begin.',
            false,
          ),
          const SizedBox(height: 16),
          _buildItem(
            Icons.low_priority_rounded,
            'No Actionable Sequence',
            'Tasks sit side-by-side without clear chronological order or prerequisites.',
            false,
          ),
          const SizedBox(height: 16),
          _buildItem(
            Icons.trending_down_rounded,
            'Cognitive Overload',
            'Seeing 30 unstructured items causes decision fatigue and inevitable procrastination.',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildSolutionCard() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFBBF7D0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFFDCFCE7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Color(0xFF16A34A),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'The ClariTask AI Engine',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF166534),
                    ),
                  ),
                  Text(
                    'Intelligent cognitive sequencing',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF15803D),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildItem(
            Icons.auto_awesome_rounded,
            'Instant Micro-Deconstruction',
            'Input one big objective. AI produces atomic, achievable 15–45 min steps.',
            true,
          ),
          const SizedBox(height: 16),
          _buildItem(
            Icons.timeline_rounded,
            'Clear Step Dependencies',
            'Every step naturally flows from the last, showing exact time estimates and milestone progress.',
            true,
          ),
          const SizedBox(height: 16),
          _buildItem(
            Icons.bolt_rounded,
            'Single Next-Step Momentum',
            'Zero friction. Focus on checking off just one step at a time with instant dopamine feedback.',
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    IconData icon,
    String title,
    String desc,
    bool isPositive,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: isPositive ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isPositive
                      ? const Color(0xFF14532D)
                      : const Color(0xFF7F1D1D),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 13,
                  color: isPositive
                      ? const Color(0xFF166534)
                      : const Color(0xFF991B1B),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
