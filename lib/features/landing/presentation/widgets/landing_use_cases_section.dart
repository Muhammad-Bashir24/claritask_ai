import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class LandingUseCasesSection extends StatefulWidget {
  const LandingUseCasesSection({super.key});

  @override
  State<LandingUseCasesSection> createState() => _LandingUseCasesSectionState();
}

class _LandingUseCasesSectionState extends State<LandingUseCasesSection> {
  int _activeTab = 0;

  // The 6 exact use cases from Section 5 & 10 of the Product Brief
  final List<_UseCaseItem> _useCases = [
    _UseCaseItem(
      category: 'Studying',
      icon: Icons.school_outlined,
      tagline: 'Break an examination preparation task into study actions',
      examplePrompt: '"Prepare for my upcoming Biology midterm examination."',
      steps: [
        'Review syllabus topics and list the 4 chapters covered.',
        'Synthesize class lecture slides into concise summary sheets.',
        'Practice 20 multiple-choice questions from past semester exams.',
        'Test yourself on difficult concepts with flashcard active recall.',
        'Take a 45-minute timed mock test to evaluate readiness.',
      ],
    ),
    _UseCaseItem(
      category: 'Development',
      icon: Icons.code_rounded,
      tagline: 'Turn an app idea into practical development steps',
      examplePrompt: '"Build a personal portfolio website with Flutter Web."',
      steps: [
        'Decide what sections your portfolio should contain.',
        'Choose the technologies and libraries you want to use.',
        'Create the project and establish clean directory structure.',
        'Design the responsive homepage layout for mobile and desktop.',
        'Add project showcases, contact links, and deploy online.',
      ],
    ),
    _UseCaseItem(
      category: 'Business',
      icon: Icons.business_center_outlined,
      tagline: 'Break an operational task into manageable actions',
      examplePrompt: '"Set up client onboarding and automated invoicing."',
      steps: [
        'Document the required intake information for new clients.',
        'Configure the payment gateway and invoice templates.',
        'Set up automated welcome email sequence upon contract signing.',
        'Test the complete onboarding workflow with a test customer.',
      ],
    ),
    _UseCaseItem(
      category: 'Cooking',
      icon: Icons.restaurant_menu_rounded,
      tagline: 'Organize meal preparation into clear steps',
      examplePrompt: '"Prepare a home-cooked dinner party for 6 guests."',
      steps: [
        'Select the main course and check for guest dietary restrictions.',
        'Write out the grocery list organized by supermarket aisle.',
        'Pre-chop vegetables and prepare marinades the morning before.',
        'Set the dining table and start oven pre-heating 90 minutes prior.',
        'Plate dishes and serve fresh and warm.',
      ],
    ),
    _UseCaseItem(
      category: 'Content Creation',
      icon: Icons.video_camera_front_outlined,
      tagline: 'Turn a content idea into an execution process',
      examplePrompt: '"Produce and publish an educational tutorial video."',
      steps: [
        'Outline key teaching points and script the 30-second hook.',
        'Record the screen demo and microphone voiceover cleanly.',
        'Edit pauses, add zoom-in callouts and background audio.',
        'Design a high-contrast thumbnail and write title description.',
        'Publish video and share link across social channels.',
      ],
    ),
    _UseCaseItem(
      category: 'Personal Tasks',
      icon: Icons.home_outlined,
      tagline: 'Organize everyday responsibilities and projects',
      examplePrompt: '"Deep clean and organize the home office workspace."',
      steps: [
        'Clear everything off the desk and wipe down surfaces.',
        'Sort paperwork into shred, file, and action piles.',
        'Bundle loose monitor and charging cables with cable ties.',
        'Organize desk drawers by grouping writing and tech supplies.',
        'Empty the trash and set up a clean, distraction-free setup.',
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
                'REAL-WORLD USE CASES',
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
              'Designed for Everyday Execution',
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
              constraints: const BoxConstraints(maxWidth: 680),
              child: const Text(
                'Whether for study, technical work, cooking, creative projects, or home tasks, ClariTaskAI provides clear momentum.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 36),

            // Tab Selector
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_useCases.length, (index) {
                  final isSelected = index == _activeTab;
                  final item = _useCases[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      selected: isSelected,
                      avatar: Icon(
                        item.icon,
                        size: 16,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF64748B),
                      ),
                      label: Text(item.category),
                      labelStyle: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF475569),
                      ),
                      selectedColor: const Color(0xFF0F172A),
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: isSelected
                            ? const Color(0xFF0F172A)
                            : const Color(0xFFCBD5E1),
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _activeTab = index);
                        }
                      },
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 32),

            // Active Use Case Display Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(context.isMobile ? 20 : 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
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
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          active.icon,
                          size: 22,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              active.category,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              active.tagline,
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
                  const SizedBox(height: 20),
                  const Divider(color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 16),

                  // Prompt
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.format_quote_rounded,
                          size: 16,
                          color: Color(0xFF2563EB),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            active.examplePrompt,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Generated Actionable Steps:',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(height: 12),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: active.steps.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            margin: const EdgeInsets.only(top: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2563EB).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2563EB),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              active.steps[index],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1E293B),
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
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

class _UseCaseItem {
  final String category;
  final IconData icon;
  final String tagline;
  final String examplePrompt;
  final List<String> steps;

  _UseCaseItem({
    required this.category,
    required this.icon,
    required this.tagline,
    required this.examplePrompt,
    required this.steps,
  });
}
