import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class LandingProblemSolutionSection extends StatelessWidget {
  const LandingProblemSolutionSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                color: const Color(0xFF2563EB).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'THE CHALLENGE & THE SOLUTION',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2563EB),
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Headline (Directly from Brief Section 3 & 10)
            Text(
              'Sometimes, the hardest part is knowing where to start.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.isMobile ? 26 : 36,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
                letterSpacing: -0.6,
              ),
            ),
            const SizedBox(height: 14),

            // Supporting explanation (from Brief Section 2 & 3)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: const Text(
                'People regularly have tasks they need to complete but struggle with knowing where to begin. The problem isn’t always a lack of motivation—sometimes people simply need clarity about what to do next.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF475569),
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 48),

            // 5 Real-world struggles from Section 2 of Brief
            if (context.isWide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: _buildStrugglesColumn(),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    flex: 4,
                    child: _buildSolutionCard(),
                  ),
                ],
              )
            else ...[
              _buildStrugglesColumn(),
              const SizedBox(height: 32),
              _buildSolutionCard(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStrugglesColumn() {
    final struggles = [
      _StruggleItem(
        persona: 'Students',
        icon: Icons.school_outlined,
        dilemma:
            'Needs to prepare for an examination but doesn’t know how to organize the study process.',
      ),
      _StruggleItem(
        persona: 'Developers',
        icon: Icons.code_rounded,
        dilemma:
            'Wants to build an application but doesn’t know how to break the development process into manageable actions.',
      ),
      _StruggleItem(
        persona: 'Homemakers & Cooking',
        icon: Icons.restaurant_menu_rounded,
        dilemma:
            'Wants to cook a particular meal but needs help organizing the preparation and timing.',
      ),
      _StruggleItem(
        persona: 'Business Owners',
        icon: Icons.business_center_outlined,
        dilemma:
            'Has an important operational task but struggles to identify the sequence of steps required to execute it.',
      ),
      _StruggleItem(
        persona: 'Content Creators',
        icon: Icons.video_library_outlined,
        dilemma:
            'Has a creative idea but doesn’t know how to turn it into practical actions.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Where People Get Stuck',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A lack of structure leads to hesitation and delay.',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: struggles.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = struggles[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      item.icon,
                      size: 18,
                      color: const Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.persona,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.dilemma,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF64748B),
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSolutionCard() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.1),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'HOW CLARITASK HELPS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Turn unclear tasks into structured, actionable steps.',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Instead of worrying about how to organize, you get immediate clarity about what to do next.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF94A3B8),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 24),
          const Divider(color: Color(0xFF334155)),
          const SizedBox(height: 20),
          _buildSolutionStep(
            number: '1',
            title: 'Describe what you need to do',
            detail: 'Use simple words to express your task.',
          ),
          const SizedBox(height: 16),
          _buildSolutionStep(
            number: '2',
            title: 'Receive practical steps',
            detail: 'AI generates a clear sequence of manageable actions.',
          ),
          const SizedBox(height: 16),
          _buildSolutionStep(
            number: '3',
            title: 'Take action one step at a time',
            detail: 'Check off steps and track your progress to completion.',
          ),
        ],
      ),
    );
  }

  Widget _buildSolutionStep({
    required String number,
    required String title,
    required String detail,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: const BoxDecoration(
            color: Color(0xFF2563EB),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                detail,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94A3B8),
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

class _StruggleItem {
  final String persona;
  final IconData icon;
  final String dilemma;

  _StruggleItem({
    required this.persona,
    required this.icon,
    required this.dilemma,
  });
}
