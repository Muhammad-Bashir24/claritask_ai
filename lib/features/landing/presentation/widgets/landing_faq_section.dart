import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class LandingFaqSection extends StatefulWidget {
  const LandingFaqSection({super.key});

  @override
  State<LandingFaqSection> createState() => _LandingFaqSectionState();
}

class _LandingFaqSectionState extends State<LandingFaqSection> {
  final List<bool> _expanded = [false, false, false, false, false];

  final List<_FaqItem> _faqs = [
    _FaqItem(
      question: 'Is ClariTask AI only on web or also on mobile?',
      answer:
          'ClariTask AI offers a full, responsive web experience tailored for desktop monitors and laptop browsers, along with companion mobile apps for iOS and Android. All your tasks, steps, and progress synchronize in real-time.',
    ),
    _FaqItem(
      question: 'How does ClariTask AI break down complex goals?',
      answer:
          'Our cognitive decomposition engine analyzes your task statement, categorizes its domain (tech, study, business, home), determines prerequisite dependencies, and sequences the work into manageable 15–45 minute micro-actions.',
    ),
    _FaqItem(
      question: 'Can I add, edit, or customize the generated steps?',
      answer:
          'Absolutely! Once ClariTask AI generates your step-by-step roadmap, you can check off completed items, add your own custom steps, adjust descriptions, and modify the plan to match your exact working style.',
    ),
    _FaqItem(
      question: 'Is it free to get started?',
      answer:
          'Yes, ClariTask AI is free to start with full access to task creation, AI breakdown, and cloud synchronization. No credit card or trial expiration is required.',
    ),
    _FaqItem(
      question: 'Is my task data private and secure?',
      answer:
          'We treat your productivity data with strict confidentiality. All authentication and database operations are powered by Supabase with Row Level Security (RLS) and TLS encryption. Your private task data is never used to train public models.',
    ),
  ];

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
        maxWidth: 820,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF243B6B).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'FREQUENTLY ASKED QUESTIONS',
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
              'Questions? We Have Answers.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.isMobile ? 24 : 34,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Everything you need to know about the product and web accessibility.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 40),

            // FAQ Accordion List using Material to avoid ListTile background assertions
            ...List.generate(_faqs.length, (index) {
              final faq = _faqs[index];
              final isExpanded = _expanded[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Material(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: isExpanded
                          ? const Color(0xFF0F172A).withValues(alpha: 0.4)
                          : const Color(0xFFE2E8F0),
                      width: isExpanded ? 1.5 : 1,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      initiallyExpanded: isExpanded,
                      onExpansionChanged: (expanded) {
                        setState(() {
                          _expanded[index] = expanded;
                        });
                      },
                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 6,
                      ),
                      childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      title: Text(
                        faq.question,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      iconColor: const Color(0xFF0F172A),
                      collapsedIconColor: const Color(0xFF64748B),
                      children: [
                        Text(
                          faq.answer,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF475569),
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _FaqItem {
  final String question;
  final String answer;

  _FaqItem({required this.question, required this.answer});
}
