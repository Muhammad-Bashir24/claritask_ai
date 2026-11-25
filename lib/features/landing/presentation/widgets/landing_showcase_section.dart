import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class LandingShowcaseSection extends StatefulWidget {
  const LandingShowcaseSection({super.key});

  @override
  State<LandingShowcaseSection> createState() => _LandingShowcaseSectionState();
}

class _LandingShowcaseSectionState extends State<LandingShowcaseSection> {
  int _activeScreen = 0;

  final List<_ScreenShowcase> _screens = [
    _ScreenShowcase(
      id: 'dashboard',
      label: 'Home Dashboard',
      icon: Icons.dashboard_outlined,
      title: 'A clean overview of what you are working on',
      description:
          'Access all your active tasks, monitor total completions, and jump directly into any workspace.',
    ),
    _ScreenShowcase(
      id: 'creation',
      label: 'Task Creation',
      icon: Icons.add_circle_outline_rounded,
      title: 'Describe what you want to achieve',
      description:
          'Type in natural language or use voice task input to describe your goal without worrying about formatting.',
    ),
    _ScreenShowcase(
      id: 'breakdown',
      label: 'AI Breakdown',
      icon: Icons.auto_awesome_outlined,
      title: 'Automated sequence of practical steps',
      description:
          'ClariTaskAI parses dependencies and generates logical, step-by-step instructions from start to finish.',
    ),
    _ScreenShowcase(
      id: 'workspace',
      label: 'Task Workspace',
      icon: Icons.checklist_rounded,
      title: 'A distraction-free execution interface',
      description:
          'Work through one step at a time, check off completed actions, and maintain clear focus.',
    ),
    _ScreenShowcase(
      id: 'progress',
      label: 'Progress Tracking',
      icon: Icons.trending_up_rounded,
      title: 'Real-time visibility into your momentum',
      description:
          'Watch your progress advance with every checkmark until the task is marked 100% complete.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final active = _screens[_activeScreen];

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
                'PRODUCT SHOWCASE',
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
              'A Workspace Designed for Execution',
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
                'Experience how ClariTaskAI guides you from an initial thought to complete execution.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 36),

            // Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_screens.length, (index) {
                  final isSelected = index == _activeScreen;
                  final screen = _screens[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      selected: isSelected,
                      avatar: Icon(
                        screen.icon,
                        size: 16,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF64748B),
                      ),
                      label: Text(screen.label),
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
                          setState(() => _activeScreen = index);
                        }
                      },
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 32),

            // Screen Mockup Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Mockup Window Bar
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEF4444),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF59E0B),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Text(
                          active.label,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Screen Content
                  Padding(
                    padding: EdgeInsets.all(context.isMobile ? 20 : 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          active.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          active.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748B),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildScreenContent(_activeScreen, context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenContent(int screenIndex, BuildContext context) {
    switch (screenIndex) {
      case 0: // Dashboard
        return _buildDashboardMockup();
      case 1: // Task Creation
        return _buildTaskCreationMockup();
      case 2: // AI Breakdown
        return _buildAiBreakdownMockup();
      case 3: // Workspace
        return _buildWorkspaceMockup();
      case 4: // Progress Tracking
        return _buildProgressMockup();
      default:
        return const SizedBox();
    }
  }

  Widget _buildDashboardMockup() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Tasks',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.add, size: 14, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'New Task',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTaskDashboardItem(
            title: 'Build personal portfolio website',
            stepsSummary: '3 of 8 steps completed',
            progress: 0.375,
            tag: 'Coding',
          ),
          const SizedBox(height: 10),
          _buildTaskDashboardItem(
            title: 'Prepare for Biology midterm examination',
            stepsSummary: '5 of 5 steps completed',
            progress: 1.0,
            tag: 'Study',
            isDone: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTaskDashboardItem({
    required String title,
    required String stepsSummary,
    required double progress,
    required String tag,
    bool isDone = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(
            isDone ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isDone ? const Color(0xFF10B981) : const Color(0xFF2563EB),
            size: 20,
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
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stepsSummary,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Text(
              tag,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF475569),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCreationMockup() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What do you need to get done?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: const Text(
              'I want to build a personal portfolio website with Flutter Web and deploy it...',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.mic, size: 16),
                label: const Text('Voice Input'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF475569),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.auto_awesome, size: 16),
                label: const Text('Break Down Task'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F172A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAiBreakdownMockup() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, size: 18, color: Color(0xFF2563EB)),
              const SizedBox(width: 8),
              const Text(
                'Generated Steps Sequence',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '8 Steps',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF166534),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildMiniStepRow('1', 'Decide portfolio sections and requirements'),
          _buildMiniStepRow('2', 'Select technologies and setup Flutter Web project'),
          _buildMiniStepRow('3', 'Build homepage with responsive layout'),
          _buildMiniStepRow('4', 'Deploy website and test live domain'),
        ],
      ),
    );
  }

  Widget _buildMiniStepRow(String num, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: const Color(0xFFF1F5F9),
            child: Text(
              num,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF334155)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, color: Color(0xFF334155)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkspaceMockup() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Active Execution Workspace',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),
          _buildWorkspaceCheckItem(
            'Decide what sections your portfolio should contain.',
            true,
          ),
          const SizedBox(height: 8),
          _buildWorkspaceCheckItem(
            'Choose the technologies you want to use.',
            true,
          ),
          const SizedBox(height: 8),
          _buildWorkspaceCheckItem(
            'Create a new project and configure folder structure.',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildWorkspaceCheckItem(String text, bool completed) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: completed ? const Color(0xFFF8FAFC) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: completed ? const Color(0xFFE2E8F0) : const Color(0xFFCBD5E1),
        ),
      ),
      child: Row(
        children: [
          Icon(
            completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: completed ? const Color(0xFF10B981) : const Color(0xFF94A3B8),
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: completed ? const Color(0xFF94A3B8) : const Color(0xFF1E293B),
                decoration: completed ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressMockup() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Task Completion Meter',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                '75% Complete',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2563EB),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: const LinearProgressIndicator(
              value: 0.75,
              minHeight: 10,
              backgroundColor: Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            '6 of 8 steps completed. 2 steps remaining until total completion.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScreenShowcase {
  final String id;
  final String label;
  final IconData icon;
  final String title;
  final String description;

  _ScreenShowcase({
    required this.id,
    required this.label,
    required this.icon,
    required this.title,
    required this.description,
  });
}
