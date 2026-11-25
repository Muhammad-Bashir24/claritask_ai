import 'package:claritask_ai/features/landing/presentation/widgets/landing_benefits_section.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_cta_banner.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_features_section.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_footer.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_hero_section.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_how_it_works_section.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_navbar.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_problem_solution_section.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_showcase_section.dart';
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
  final GlobalKey _useCasesKey = GlobalKey();
  final GlobalKey _showcaseKey = GlobalKey();
  final GlobalKey _benefitsKey = GlobalKey();

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
            // Section 1: Navigation
            LandingNavbar(
              onFeaturesTap: () => _scrollToKey(_featuresKey),
              onHowItWorksTap: () => _scrollToKey(_howItWorksKey),
              onUseCasesTap: () => _scrollToKey(_useCasesKey),
              onShowcaseTap: () => _scrollToKey(_showcaseKey),
              onBenefitsTap: () => _scrollToKey(_benefitsKey),
            ),

            // Scrollable Content (Sections 2 through 9)
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Section 2: Hero
                    LandingHeroSection(
                      onSeeHowItWorksTap: () => _scrollToKey(_howItWorksKey),
                    ),

                    // Section 3: Problem and Solution
                    const LandingProblemSolutionSection(),

                    // Section 4: How It Works
                    KeyedSubtree(
                      key: _howItWorksKey,
                      child: const LandingHowItWorksSection(),
                    ),

                    // Section 5: Use Cases
                    KeyedSubtree(
                      key: _useCasesKey,
                      child: const LandingUseCasesSection(),
                    ),

                    // Section 6: Product Showcase
                    KeyedSubtree(
                      key: _showcaseKey,
                      child: const LandingShowcaseSection(),
                    ),

                    // Section 7: Practical Benefits
                    KeyedSubtree(
                      key: _benefitsKey,
                      child: const LandingBenefitsSection(),
                    ),

                    // Core MVP Features
                    KeyedSubtree(
                      key: _featuresKey,
                      child: const LandingFeaturesSection(),
                    ),

                    // Section 8: Final CTA
                    const LandingCtaBanner(),

                    // Section 9: Footer
                    LandingFooter(
                      onFeaturesTap: () => _scrollToKey(_featuresKey),
                      onHowItWorksTap: () => _scrollToKey(_howItWorksKey),
                      onUseCasesTap: () => _scrollToKey(_useCasesKey),
                      onShowcaseTap: () => _scrollToKey(_showcaseKey),
                      onBenefitsTap: () => _scrollToKey(_benefitsKey),
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
