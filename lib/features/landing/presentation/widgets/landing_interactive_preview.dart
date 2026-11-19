import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingInteractivePreview extends StatefulWidget {
  const LandingInteractivePreview({super.key});

  @override
  State<LandingInteractivePreview> createState() =>
      _LandingInteractivePreviewState();
}

class _LandingInteractivePreviewState extends State<LandingInteractivePreview> {
  int _selectedPresetIndex = 0;
  final TextEditingController _customInputController = TextEditingController();

  final List<_DemoPreset> _presets = [
    _DemoPreset(
      title: 'Build Flutter Task App with Supabase',
      badge: 'Coding & Tech',
      badgeColor: Color(0xFF6366F1),
      estimatedTime: '2 hrs 15 mins',
      steps: [
        _DemoStep(
          id: '1',
          title: 'Define domain entities & Supabase database schema',
          description:
              'Create tasks and task_steps tables with foreign key relations and RLS policies.',
          duration: '30m',
          isCompleted: true,
        ),
        _DemoStep(
          id: '2',
          title: 'Implement Auth & Supabase remote datasource',
          description:
              'Wire up Supabase client, user session streams, and dependency injection.',
          duration: '45m',
          isCompleted: true,
        ),
        _DemoStep(
          id: '3',
          title: 'Build responsive task workspace UI & step checklist',
          description:
              'Design interactive cards with step toggle, completion percentages, and animations.',
          duration: '40m',
          isCompleted: false,
        ),
        _DemoStep(
          id: '4',
          title: 'Connect AI breakdown endpoint & test error states',
          description:
              'Send task description to LLM prompt, parse returned JSON steps, and persist.',
          duration: '20m',
          isCompleted: false,
        ),
      ],
    ),
    _DemoPreset(
      title: 'Prepare & Ace Organic Chemistry Midterm',
      badge: 'School & Study',
      badgeColor: Color(0xFF10B981),
      estimatedTime: '3 hrs 30 mins',
      steps: [
        _DemoStep(
          id: '1',
          title: 'Review reaction mechanisms for chapters 4 to 6',
          description:
              'Synthesize SN1/SN2 nucleophilic substitution reaction paths into 1-page cheatsheets.',
          duration: '50m',
          isCompleted: true,
        ),
        _DemoStep(
          id: '2',
          title: 'Complete 25 practice problems on stereochemistry',
          description:
              'Focus on R/S enantiomer configurations and chair conformations.',
          duration: '60m',
          isCompleted: false,
        ),
        _DemoStep(
          id: '3',
          title: 'Timed mock exam using 2025 previous midterm',
          description:
              'Simulate test conditions without notes to diagnose weak concepts.',
          duration: '60m',
          isCompleted: false,
        ),
        _DemoStep(
          id: '4',
          title: 'Review missed problems with flashcard active recall',
          description:
              'Clarify incorrect mechanisms and re-test difficult reagents.',
          duration: '40m',
          isCompleted: false,
        ),
      ],
    ),
    _DemoPreset(
      title: 'Launch SaaS Product on ProductHunt',
      badge: 'Startup & Growth',
      badgeColor: Color(0xFFF59E0B),
      estimatedTime: '4 hrs 00 mins',
      steps: [
        _DemoStep(
          id: '1',
          title: 'Finalize demo video, tagline & 5 gallery screenshots',
          description:
              'Showcase the core value proposition in the first 5 seconds of the demo.',
          duration: '75m',
          isCompleted: true,
        ),
        _DemoStep(
          id: '2',
          title: 'Draft Maker first comment & founder journey story',
          description:
              'Include what problem inspired Claritask AI, tech stack, and special community promo.',
          duration: '35m',
          isCompleted: true,
        ),
        _DemoStep(
          id: '3',
          title: 'Prepare launch outreach list for Twitter, LinkedIn, and Discord',
          description:
              'Notify beta testers and early supporters with direct links at 12:01 AM PST.',
          duration: '50m',
          isCompleted: false,
        ),
        _DemoStep(
          id: '4',
          title: 'Monitor live comments & reply within 10 minutes',
          description:
              'Engage every comment and gather real-time feature feedback for v1.1.',
          duration: '80m',
          isCompleted: false,
        ),
      ],
    ),
    _DemoPreset(
      title: 'Meal Prep Healthy Dinners for the Week',
      badge: 'Home & Life',
      badgeColor: Color(0xFFEC4899),
      estimatedTime: '1 hr 45 mins',
      steps: [
        _DemoStep(
          id: '1',
          title: 'Select 3 high-protein recipes & build grocery list',
          description:
              'Plan meals sharing overlapping ingredients (grilled salmon, quinoa bowls, roasted veggies).',
          duration: '20m',
          isCompleted: true,
        ),
        _DemoStep(
          id: '2',
          title: 'Chop and batch roast vegetables at 400°F',
          description:
              'Prep sweet potatoes, broccoli, and bell peppers with olive oil and spices.',
          duration: '35m',
          isCompleted: false,
        ),
        _DemoStep(
          id: '3',
          title: 'Cook protein bases (salmon & marinated chicken)',
          description:
              'Season and sear proteins in two separate batches for fresh flavor.',
          duration: '30m',
          isCompleted: false,
        ),
        _DemoStep(
          id: '4',
          title: 'Portion into 6 airtight glass meal containers',
          description:
              'Label by day and refrigerate, storing sauces separately to keep textures crisp.',
          duration: '20m',
          isCompleted: false,
        ),
      ],
    ),
  ];

  late List<List<bool>> _stepCompletionStates;

  @override
  void initState() {
    super.initState();
    _stepCompletionStates = _presets.map((preset) {
      return preset.steps.map((s) => s.isCompleted).toList();
    }).toList();
  }

  @override
  void dispose() {
    _customInputController.dispose();
    super.dispose();
  }

  void _toggleStep(int presetIdx, int stepIdx) {
    setState(() {
      _stepCompletionStates[presetIdx][stepIdx] =
          !_stepCompletionStates[presetIdx][stepIdx];
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPreset = _presets[_selectedPresetIndex];
    final currentCompletions = _stepCompletionStates[_selectedPresetIndex];
    final completedCount = currentCompletions.where((c) => c).length;
    final totalCount = currentCompletions.length;
    final progress = totalCount > 0 ? completedCount / totalCount : 0.0;

    return ResponsiveContainer(
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 16 : 28,
        vertical: 32,
      ),
      child: Column(
        children: [
          // Section Title
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'LIVE INTERACTIVE SIMULATOR',
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
            'See How ClariTask AI Breaks Down Any Goal',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.isMobile ? 24 : 32,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Click an example goal below or test checking off live steps to see the cognitive flow.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 28),

          // Preset Chips Selector
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: List.generate(_presets.length, (index) {
              final preset = _presets[index];
              final isSelected = index == _selectedPresetIndex;

              return ChoiceChip(
                label: Text(preset.title),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedPresetIndex = index;
                    });
                  }
                },
                selectedColor: const Color(0xFF0F172A),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF334155),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isSelected
                        ? const Color(0xFF0F172A)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              );
            }),
          ),
          const SizedBox(height: 28),

          // Main Interactive Workspace Card
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Mock Browser / App Bar Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 18,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Window dots
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
                      // Mock search/status bar
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.auto_awesome,
                                size: 14,
                                color: Color(0xFF10B981),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'ClariTask AI Workspace • ${currentPreset.title}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF475569),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: currentPreset.badgeColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          currentPreset.badge,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: currentPreset.badgeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Workspace Content
                Padding(
                  padding: EdgeInsets.all(context.isMobile ? 18 : 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Task Title & Overall Progress Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'ACTIVE OBJECTIVE',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF64748B),
                                    letterSpacing: 1.1,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  currentPreset.title,
                                  style: TextStyle(
                                    fontSize: context.isMobile ? 18 : 22,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Wrap(
                                  spacing: 14,
                                  runSpacing: 4,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.schedule_rounded,
                                          size: 14,
                                          color: Color(0xFF64748B),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Estimated: ${currentPreset.estimatedTime}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF64748B),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.list_alt_rounded,
                                          size: 14,
                                          color: Color(0xFF64748B),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '$completedCount of $totalCount steps completed',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF64748B),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${(progress * 100).toInt()}% Done',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF059669),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Animated Progress Bar (Safe bounded width)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          height: 8,
                          child: TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            tween: Tween<double>(begin: 0, end: progress),
                            builder: (context, value, child) {
                              return LinearProgressIndicator(
                                value: value,
                                backgroundColor: const Color(0xFFE2E8F0),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color(0xFF10B981),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        'AI DECONSTRUCTED ROADMAP',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF64748B),
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Step Items List
                      ...List.generate(currentPreset.steps.length, (stepIdx) {
                        final step = currentPreset.steps[stepIdx];
                        final isDone = currentCompletions[stepIdx];

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDone
                                ? const Color(0xFFF8FAFC)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isDone
                                  ? const Color(0xFFE2E8F0)
                                  : const Color(0xFFCBD5E1),
                              width: isDone ? 1 : 1.5,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Step Index / Checkbox
                              InkWell(
                                onTap: () =>
                                    _toggleStep(_selectedPresetIndex, stepIdx),
                                borderRadius: BorderRadius.circular(8),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: isDone
                                        ? const Color(0xFF10B981)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isDone
                                          ? const Color(0xFF10B981)
                                          : const Color(0xFF94A3B8),
                                      width: 2,
                                    ),
                                  ),
                                  child: isDone
                                      ? const Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Colors.white,
                                        )
                                      : Center(
                                          child: Text(
                                            '${stepIdx + 1}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF64748B),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(width: 14),

                              // Step Content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            step.title,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: isDone
                                                  ? const Color(0xFF94A3B8)
                                                  : const Color(0xFF0F172A),
                                              decoration: isDone
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF1F5F9),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            step.duration,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF475569),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      step.description,
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        color: isDone
                                            ? const Color(0xFFCBD5E1)
                                            : const Color(0xFF64748B),
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 16),

                      // Call to action button inside preview
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A).withValues(alpha: 0.03),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Want to break down your own specific project with AI?',
                                style: TextStyle(
                                  fontSize: context.isMobile ? 12 : 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF334155),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () => context.push('/auth'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0F172A),
                                foregroundColor: Colors.white,
                                minimumSize: Size.zero,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Try In App Free'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoPreset {
  final String title;
  final String badge;
  final Color badgeColor;
  final String estimatedTime;
  final List<_DemoStep> steps;

  _DemoPreset({
    required this.title,
    required this.badge,
    required this.badgeColor,
    required this.estimatedTime,
    required this.steps,
  });
}

class _DemoStep {
  final String id;
  final String title;
  final String description;
  final String duration;
  final bool isCompleted;

  _DemoStep({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.isCompleted,
  });
}
