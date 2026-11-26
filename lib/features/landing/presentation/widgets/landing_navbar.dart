import 'package:claritask_ai/features/landing/presentation/widgets/landing_store_buttons.dart';
import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingNavbar extends StatelessWidget {
  final VoidCallback onFeaturesTap;
  final VoidCallback onHowItWorksTap;
  final VoidCallback onUseCasesTap;
  final VoidCallback onShowcaseTap;
  final VoidCallback onBenefitsTap;
  final VoidCallback onJoinWaitlistTap;

  const LandingNavbar({
    super.key,
    required this.onFeaturesTap,
    required this.onHowItWorksTap,
    required this.onUseCasesTap,
    required this.onShowcaseTap,
    required this.onBenefitsTap,
    required this.onJoinWaitlistTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: ResponsiveContainer(
        maxWidth: 1100,
        padding: EdgeInsets.symmetric(
          horizontal: context.isMobile ? 16 : 32,
          vertical: 14,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Brand Logo & Title
            InkWell(
              onTap: () => context.go('/landing'),
              borderRadius: BorderRadius.circular(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      'assets/images/Claritask_ai_logo-removebg-preview.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'ClariTaskAI',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),

            // Desktop Navigation Links
            if (context.isWide)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _NavButton(title: 'Features', onTap: onFeaturesTap),
                  _NavButton(title: 'How It Works', onTap: onHowItWorksTap),
                  _NavButton(title: 'Use Cases', onTap: onUseCasesTap),
                  _NavButton(title: 'Showcase', onTap: onShowcaseTap),
                  _NavButton(title: 'Benefits', onTap: onBenefitsTap),
                ],
              ),

            // Waitlist Action & Mobile Menu Toggle
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: onJoinWaitlistTap,
                  icon: const Icon(Icons.mail_outline_rounded, size: 16),
                  label: Text(
                    context.isMobile ? 'Waitlist' : 'Join Waitlist',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A),
                    foregroundColor: Colors.white,
                    minimumSize: Size.zero,
                    padding: EdgeInsets.symmetric(
                      horizontal: context.isMobile ? 14 : 18,
                      vertical: 10,
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // Mobile Menu Toggle
                if (!context.isWide) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.menu_rounded, color: Color(0xFF0F172A)),
                    onPressed: () => _showMobileMenu(context),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
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
            constraints: BoxConstraints(maxHeight: screenHeight * 0.85),
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
                    leading: const Icon(Icons.auto_awesome_outlined),
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
                    title: const Text('Use Cases'),
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      onUseCasesTap();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.laptop_chromebook_rounded),
                    title: const Text('Product Showcase'),
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      onShowcaseTap();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.task_alt_rounded),
                    title: const Text('Practical Benefits'),
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      onBenefitsTap();
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(sheetContext).pop();
                      onJoinWaitlistTap();
                    },
                    icon: const Icon(Icons.mail_outline_rounded, size: 18),
                    label: const Text('Join the Waitlist'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F172A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Mobile App Coming Soon',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  LandingStoreButtons(
                    onNotifyMeTap: () {
                      Navigator.of(sheetContext).pop();
                      onJoinWaitlistTap();
                    },
                  ),
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF475569),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
