import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class LandingFooter extends StatelessWidget {
  final VoidCallback onFeaturesTap;
  final VoidCallback onHowItWorksTap;
  final VoidCallback onUseCasesTap;
  final VoidCallback onShowcaseTap;
  final VoidCallback onBenefitsTap;

  const LandingFooter({
    super.key,
    required this.onFeaturesTap,
    required this.onHowItWorksTap,
    required this.onUseCasesTap,
    required this.onShowcaseTap,
    required this.onBenefitsTap,
  });

  void _showPolicyDialog(BuildContext context, String title, String body) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Text(
            body,
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0F172A),
      padding: EdgeInsets.symmetric(
        vertical: context.isMobile ? 40 : 64,
        horizontal: 24,
      ),
      child: ResponsiveContainer(
        maxWidth: 1080,
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
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/Claritask_ai_logo-removebg-preview.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.auto_awesome,
                                color: Color(0xFF0F172A),
                                size: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'ClariTaskAI',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      // Exact Brand Messaging from Brief Section 7 & 14
                      const Text(
                        'ClariTaskAI turns the things you need to get done into simple steps you can actually take. Work through them. Get things done.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF94A3B8),
                          height: 1.55,
                        ),
                      ),
                    ],
                  ),
                ),

                if (context.isWide) ...[
                  const SizedBox(width: 48),

                  // Navigation Links Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Navigation',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _FooterLink(title: 'Features', onTap: onFeaturesTap),
                        _FooterLink(title: 'How It Works', onTap: onHowItWorksTap),
                        _FooterLink(title: 'Use Cases', onTap: onUseCasesTap),
                        _FooterLink(title: 'Product Showcase', onTap: onShowcaseTap),
                        _FooterLink(title: 'Benefits', onTap: onBenefitsTap),
                      ],
                    ),
                  ),

                  // Legal & Support Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Legal & Contact',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _FooterLink(
                          title: 'Privacy Policy',
                          onTap: () => _showPolicyDialog(
                            context,
                            'Privacy Policy',
                            'ClariTaskAI respects your privacy. We do not sell your personal data or task inputs. Tasks you create are securely processed to generate actionable breakdowns and saved to your account in encrypted storage.',
                          ),
                        ),
                        _FooterLink(
                          title: 'Terms of Service',
                          onTap: () => _showPolicyDialog(
                            context,
                            'Terms of Service',
                            'ClariTaskAI is provided as an AI execution assistant. You remain responsible for carrying out the generated actions. The service is provided as-is with commitment to reliability and data security.',
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Contact:',
                          style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'support@claritask.ai',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),

            if (!context.isWide) ...[
              const SizedBox(height: 32),
              const Divider(color: Color(0xFF1E293B)),
              const SizedBox(height: 20),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  _FooterLink(title: 'Features', onTap: onFeaturesTap),
                  _FooterLink(title: 'How It Works', onTap: onHowItWorksTap),
                  _FooterLink(title: 'Use Cases', onTap: onUseCasesTap),
                  _FooterLink(title: 'Showcase', onTap: onShowcaseTap),
                  _FooterLink(title: 'Benefits', onTap: onBenefitsTap),
                  _FooterLink(
                    title: 'Privacy',
                    onTap: () => _showPolicyDialog(
                      context,
                      'Privacy Policy',
                      'ClariTaskAI respects your privacy. We do not sell your personal data or task inputs.',
                    ),
                  ),
                  _FooterLink(
                    title: 'Terms',
                    onTap: () => _showPolicyDialog(
                      context,
                      'Terms of Service',
                      'ClariTaskAI is provided as an execution assistant.',
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 36),
            const Divider(color: Color(0xFF1E293B)),
            const SizedBox(height: 20),

            // Bottom bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '© ${DateTime.now().year} ClariTaskAI. All rights reserved.',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
                const Text(
                  'Turn any task into simple steps.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
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
      padding: const EdgeInsets.symmetric(vertical: 4),
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
