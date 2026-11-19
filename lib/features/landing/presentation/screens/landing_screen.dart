import 'package:claritask_ai/features/landing/presentation/widgets/landing_cta_banner.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_faq_section.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_features_section.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_footer.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_hero_section.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_how_it_works_section.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_interactive_preview.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_metrics_section.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_navbar.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_problem_solution_section.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_testimonials_section.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_use_cases_section.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _howItWorksKey = GlobalKey();
  final GlobalKey _personasKey = GlobalKey();
  final GlobalKey _testimonialsKey = GlobalKey();
  final GlobalKey _faqKey = GlobalKey();
  final GlobalKey _demoKey = GlobalKey();

  void _scrollToKey(GlobalKey key) {
    final targetContext = key.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            LandingNavbar(
              onFeaturesTap: () => _scrollToKey(_featuresKey),
              onHowItWorksTap: () => _scrollToKey(_howItWorksKey),
              onPersonasTap: () => _scrollToKey(_personasKey),
              onTestimonialsTap: () => _scrollToKey(_testimonialsKey),
              onFaqTap: () => _scrollToKey(_faqKey),
            ),

            // Scrollable Page Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    LandingHeroSection(
                      onTryDemoTap: () => _scrollToKey(_demoKey),
                    ),
                    const LandingMetricsSection(),
                    KeyedSubtree(
                      key: _demoKey,
                      child: const LandingInteractivePreview(),
                    ),
                    const LandingProblemSolutionSection(),
                    KeyedSubtree(
                      key: _featuresKey,
                      child: const LandingFeaturesSection(),
                    ),
                    KeyedSubtree(
                      key: _howItWorksKey,
                      child: const LandingHowItWorksSection(),
                    ),
                    KeyedSubtree(
                      key: _personasKey,
                      child: const LandingUseCasesSection(),
                    ),
                    KeyedSubtree(
                      key: _testimonialsKey,
                      child: const LandingTestimonialsSection(),
                    ),
                    KeyedSubtree(
                      key: _faqKey,
                      child: const LandingFaqSection(),
                    ),
                    const LandingCtaBanner(),
                    LandingFooter(
                      onFeaturesTap: () => _scrollToKey(_featuresKey),
                      onHowItWorksTap: () => _scrollToKey(_howItWorksKey),
                      onPersonasTap: () => _scrollToKey(_personasKey),
                      onTestimonialsTap: () => _scrollToKey(_testimonialsKey),
                      onFaqTap: () => _scrollToKey(_faqKey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
