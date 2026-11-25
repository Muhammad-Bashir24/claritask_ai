import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class LandingHowItWorksSection extends StatelessWidget {
  const LandingHowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                'SIMPLE 3-STAGE FLOW',
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
              'How It Works',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.isMobile ? 26 : 36,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
                letterSpacing: -0.6,
              ),
            ),
            const SizedBox(height: 12),

            // Core Flow Indicator
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Text(
                'Describe → Break Down → Take Action → Complete',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.isMobile ? 14 : 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2563EB),
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 48),

            // The 3 Simple Stages (from Brief Section 4 & 10)
            if (context.isWide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _StageCard(
                      stageNumber: '1',
                      title: 'Tell us your task',
                      description:
                          'Describe what you need to get done using natural language or voice.',
                      example: '"I need to prepare for my Biology midterm exam."',
                      icon: Icons.chat_bubble_outline_rounded,
                    ),
                  ),
                  _buildStageConnector(),
                  Expanded(
                    child: _StageCard(
                      stageNumber: '2',
                      title: 'Get your breakdown',
                      description:
                          'ClariTaskAI turns your task into a sequence of clear, practical steps.',
                      example: '8 clear actions generated with zero guesswork.',
                      icon: Icons.auto_awesome_outlined,
                    ),
                  ),
                  _buildStageConnector(),
                  Expanded(
                    child: _StageCard(
                      stageNumber: '3',
                      title: 'Work through each step',
                      description:
                          'Complete the actions one at a time and track your progress to finish.',
                      example: 'Check off steps and stay focused on what is next.',
                      icon: Icons.check_circle_outline_rounded,
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  _StageCard(
                    stageNumber: '1',
                    title: 'Tell us your task',
                    description:
                        'Describe what you need to get done using natural language or voice.',
                    example: '"I need to prepare for my Biology midterm exam."',
                    icon: Icons.chat_bubble_outline_rounded,
                  ),
                  const SizedBox(height: 16),
                  _StageCard(
                    stageNumber: '2',
                    title: 'Get your breakdown',
                    description:
                        'ClariTaskAI turns your task into a sequence of clear, practical steps.',
                    example: '8 clear actions generated with zero guesswork.',
                    icon: Icons.auto_awesome_outlined,
                  ),
                  const SizedBox(height: 16),
                  _StageCard(
                    stageNumber: '3',
                    title: 'Work through each step',
                    description:
                        'Complete the actions one at a time and track your progress to finish.',
                    example: 'Check off steps and stay focused on what is next.',
                    icon: Icons.check_circle_outline_rounded,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageConnector() {
    return Padding(
      padding: const EdgeInsets.only(top: 48, left: 12, right: 12),
      child: Icon(
        Icons.arrow_forward_rounded,
        size: 20,
        color: const Color(0xFFCBD5E1),
      ),
    );
  }
}

class _StageCard extends StatelessWidget {
  final String stageNumber;
  final String title;
  final String description;
  final String example;
  final IconData icon;

  const _StageCard({
    required this.stageNumber,
    required this.title,
    required this.description,
    required this.example,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  stageNumber,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(icon, size: 24, color: const Color(0xFF64748B)),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Text(
              example,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF475569),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
