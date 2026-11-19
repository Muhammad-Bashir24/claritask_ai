import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class LandingFooter extends StatelessWidget {
  final VoidCallback onFeaturesTap;
  final VoidCallback onHowItWorksTap;
  final VoidCallback onPersonasTap;
  final VoidCallback onTestimonialsTap;
  final VoidCallback onFaqTap;

  const LandingFooter({
    super.key,
    required this.onFeaturesTap,
    required this.onHowItWorksTap,
    required this.onPersonasTap,
    required this.onTestimonialsTap,
    required this.onFaqTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0F172A),
      padding: EdgeInsets.symmetric(
        vertical: context.isMobile ? 40 : 60,
        horizontal: 24,
      ),
      child: ResponsiveContainer(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand Column
                Expanded(
                  flex: context.isWide ? 2 : 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(6),
                            child: Image.asset(
                              'assets/images/Claritask_ai_logo-removebg-preview.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.auto_awesome,
                                color: Color(0xFF0F172A),
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'ClariTask AI',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Your cognitive copilot for turning complex projects and study goals into manageable, frictionless momentum.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF94A3B8),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                if (context.isWide) ...[
                  const Spacer(),
                  // Navigation Links Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Product',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _FooterLink(title: 'Features', onTap: onFeaturesTap),
                      _FooterLink(title: 'How It Works', onTap: onHowItWorksTap),
                      _FooterLink(title: 'Personas', onTap: onPersonasTap),
                      _FooterLink(title: 'Testimonials', onTap: onTestimonialsTap),
                      _FooterLink(title: 'FAQ', onTap: onFaqTap),
                    ],
                  ),
                  const SizedBox(width: 60),
                  // Legal Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Legal',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _FooterLink(title: 'Privacy Policy', onTap: () {}),
                      _FooterLink(title: 'Terms of Service', onTap: () {}),
                      _FooterLink(title: 'Security', onTap: () {}),
                    ],
                  ),
                ],
              ],
            ),
            const SizedBox(height: 48),
            const Divider(color: Color(0xFF1E293B)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '© 2026 ClariTask AI. All rights reserved.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
                Text(
                  'Built with Flutter • Web & Mobile',
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _FooterLink({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF94A3B8),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
