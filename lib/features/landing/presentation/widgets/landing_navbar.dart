import 'package:claritask_ai/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LandingNavbar extends StatelessWidget {
  final VoidCallback onFeaturesTap;
  final VoidCallback onHowItWorksTap;
  final VoidCallback onPersonasTap;
  final VoidCallback onTestimonialsTap;
  final VoidCallback onFaqTap;

  const LandingNavbar({
    super.key,
    required this.onFeaturesTap,
    required this.onHowItWorksTap,
    required this.onPersonasTap,
    required this.onTestimonialsTap,
    required this.onFaqTap,
  });

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final isAuthenticated = authState is AuthAuthenticated;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF0F172A).withValues(alpha: 0.08),
          ),
        ),
      ),
      child: ResponsiveContainer(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Brand Logo & Title
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0F172A).withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(7),
                    child: Image.asset(
                      'assets/images/Claritask_ai_logo-removebg-preview.png',
                      color: Colors.white,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Row(
                    children: [
                      const Text(
                        'ClariTask',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xFF10B981).withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Text(
                          'AI',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF059669),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Desktop Nav Links
            if (context.isWide)
              Row(
                children: [
                  _NavButton(title: 'Features', onTap: onFeaturesTap),
                  _NavButton(title: 'How It Works', onTap: onHowItWorksTap),
                  _NavButton(title: 'Personas', onTap: onPersonasTap),
                  _NavButton(title: 'Testimonials', onTap: onTestimonialsTap),
                  _NavButton(title: 'FAQ', onTap: onFaqTap),
                ],
              ),

            // Auth / Dashboard Actions
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isAuthenticated) ...[
                  ElevatedButton.icon(
                    onPressed: () => context.go('/home'),
                    icon: const Icon(Icons.dashboard_rounded, size: 18),
                    label: const Text('Go to Dashboard'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F172A),
                      foregroundColor: Colors.white,
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ] else ...[
                  if (context.isWide)
                    TextButton(
                      onPressed: () => context.push('/auth'),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF334155),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: const Text('Sign In'),
                    ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => context.push('/auth'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F172A),
                      foregroundColor: Colors.white,
                      minimumSize: Size.zero,
                      padding: EdgeInsets.symmetric(
                        horizontal: context.isMobile ? 14 : 20,
                        vertical: 12,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.isMobile ? 'Open App' : 'Get Started Free',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward_rounded, size: 16),
                      ],
                    ),
                  ),
                ],

                // Mobile Menu Toggle
                if (!context.isWide) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.menu_rounded, color: Color(0xFF0F172A)),
                    onPressed: () => _showMobileMenu(context, isAuthenticated),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context, bool isAuthenticated) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        final screenHeight = MediaQuery.sizeOf(sheetContext).height;
        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: screenHeight * 0.85,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Menu',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(sheetContext).pop(),
                      ),
                    ],
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.star_outline_rounded),
                    title: const Text('Features'),
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      onFeaturesTap();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.route_outlined),
                    title: const Text('How It Works'),
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      onHowItWorksTap();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.people_outline_rounded),
                    title: const Text('Personas'),
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      onPersonasTap();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.format_quote_rounded),
                    title: const Text('Testimonials'),
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      onTestimonialsTap();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help_outline_rounded),
                    title: const Text('FAQ'),
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      onFaqTap();
                    },
                  ),
                  const SizedBox(height: 16),
                  if (isAuthenticated)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(sheetContext).pop();
                        context.go('/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F172A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Go to Dashboard'),
                    )
                  else ...[
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(sheetContext).pop();
                        context.push('/auth');
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Sign In'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(sheetContext).pop();
                        context.push('/auth');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F172A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Get Started Free'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF475569),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
