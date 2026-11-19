import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class LandingUseCasesSection extends StatefulWidget {
  const LandingUseCasesSection({super.key});

  @override
  State<LandingUseCasesSection> createState() => _LandingUseCasesSectionState();
}

class _LandingUseCasesSectionState extends State<LandingUseCasesSection> {
  int _activeTab = 0;

  final List<_UseCaseData> _useCases = [
    _UseCaseData(
      title: 'Developers & Engineers',
      icon: Icons.code_rounded,
      tagline: 'From architecture to release without getting stuck',
      exampleTask: 'Build a production-ready real-time chat with WebSockets',
      benefits: [
        'Breaks daunting specs into clean feature modules',
        'Separates frontend UI from backend data synchronization',
        'Guides testing, state management, and edge cases',
      ],
      sampleSteps: [
        'Model ChatMessage entity & socket payload contracts',
        'Configure WebSocket channel & reconnect retry logic',
        'Build message bubble widget & auto-scrolling list',
        'Handle offline persistence & unsent message queue',
      ],
    ),
    _UseCaseData(
      title: 'Students & Researchers',
      icon: Icons.school_rounded,
      tagline: 'Conquer massive syllabi and exam anxiety',
      exampleTask: 'Prepare for final exam in Cellular Biology',
      benefits: [
        'Divides semester-long textbooks into digestible 45-minute blocks',
        'Incorporates active recall and spaced repetition milestones',
        'Provides measurable progress leading right up to test day',
      ],
      sampleSteps: [
        'Review Krebs cycle and oxidative phosphorylation diagrams',
        'Complete 30 practice MCQs on cell signaling',
        'Draft summary flashcards for enzyme kinetics',
        'Take timed past exam and review incorrect answers',
      ],
    ),
    _UseCaseData(
      title: 'Founders & Solopreneurs',
      icon: Icons.rocket_launch_rounded,
      tagline: 'Execute your business roadmap without the noise',
      exampleTask: 'Launch MVP landing page and collect first 100 beta signups',
      benefits: [
        'Cuts through endless low-impact busywork',
        'Focuses purely on high-leverage launch activities',
        'Reduces founder burnout by structuring each day clearly',
      ],
      sampleSteps: [
        'Draft value proposition headline & 3 pain-point benefits',
        'Build responsive landing page & email capture form',
        'Post build-in-public announcement thread on X & LinkedIn',
        'Send welcome emails to first 25 waitlist signups',
      ],
    ),
    _UseCaseData(
      title: 'Personal & Home Life',
      icon: Icons.home_rounded,
      tagline: 'Declutter your living space and daily schedule',
      exampleTask: 'Deep clean and reorganize the garage and workspace',
      benefits: [
        'Eliminates the "where do I even start?" feeling',
        'Categorizes items into donate, recycle, and store',
        'Creates clean milestone moments you can celebrate',
      ],
      sampleSteps: [
        'Clear all items off workbench and sweep floor',
        'Sort scattered hand tools into pegboard hooks & tool chest',
        'Label storage bins for seasonal gear & holiday items',
        'Bag up donations and drop off at local center',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final active = _useCases[_activeTab];

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
                'TAILORED FOR YOU',
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
              'How Different Thinkers Use ClariTask AI',
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
              constraints: const BoxConstraints(maxWidth: 620),
              child: const Text(
                'Personalized cognitive strategies whether you are building software, studying for degrees, or launching companies.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 36),

            // Tab Buttons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: List.generate(_useCases.length, (index) {
                final isSelected = index == _activeTab;
                final item = _useCases[index];

                return InkWell(
                  onTap: () {
                    setState(() {
                      _activeTab = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF0F172A) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF0F172A)
                            : const Color(0xFFCBD5E1),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          size: 16,
                          color: isSelected ? Colors.white : const Color(0xFF64748B),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 36),

            // Active Tab Card Showcase
            Container(
              padding: EdgeInsets.all(context.isMobile ? 20 : 36),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: context.isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildDetailsColumn(active)),
                        const SizedBox(width: 36),
                        Expanded(child: _buildSampleRoadmap(active)),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildDetailsColumn(active),
                        const SizedBox(height: 28),
                        _buildSampleRoadmap(active),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsColumn(_UseCaseData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(data.icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    data.tagline,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.lightbulb_outline_rounded,
                color: Color(0xFFF59E0B),
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Example: "${data.exampleTask}"',
                  style: const TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF334155),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Key Benefits:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 12),
        ...data.benefits.map((benefit) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF10B981),
                  size: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    benefit,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF475569),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSampleRoadmap(_UseCaseData data) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'GENERATED ROADMAP PREVIEW',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64748B),
                  letterSpacing: 1.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '4 Steps Generated',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF047857),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(data.sampleSteps.length, (idx) {
            final step = data.sampleSteps[idx];
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${idx + 1}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      step,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _UseCaseData {
  final String title;
  final IconData icon;
  final String tagline;
  final String exampleTask;
  final List<String> benefits;
  final List<String> sampleSteps;

  _UseCaseData({
    required this.title,
    required this.icon,
    required this.tagline,
    required this.exampleTask,
    required this.benefits,
    required this.sampleSteps,
  });
}
