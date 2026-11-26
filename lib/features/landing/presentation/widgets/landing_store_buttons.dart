import 'package:claritask_ai/core/utils/custom_toast.dart';
import 'package:flutter/material.dart';

class LandingStoreButtons extends StatelessWidget {
  final VoidCallback? onNotifyMeTap;
  final bool isDark;

  const LandingStoreButtons({
    super.key,
    this.onNotifyMeTap,
    this.isDark = true,
  });

  void _handleStoreClick(BuildContext context, String storeName) {
    CustomToast.show(
      context: context,
      message: 'ClariTaskAI is coming soon to the $storeName! Join the waitlist to get notified.',
      type: ToastType.info,
    );
    if (onNotifyMeTap != null) {
      onNotifyMeTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        _StoreBadge(
          platformName: 'Apple App Store',
          subtext: 'Download on the',
          storeTitle: 'App Store',
          icon: Icons.apple,
          onTap: () => _handleStoreClick(context, 'Apple App Store'),
        ),
        _StoreBadge(
          platformName: 'Google Play',
          subtext: 'GET IT ON',
          storeTitle: 'Google Play',
          icon: Icons.play_arrow_rounded,
          onTap: () => _handleStoreClick(context, 'Google Play Store'),
        ),
      ],
    );
  }
}

class _StoreBadge extends StatelessWidget {
  final String platformName;
  final String subtext;
  final String storeTitle;
  final IconData icon;
  final VoidCallback onTap;

  const _StoreBadge({
    required this.platformName,
    required this.subtext,
    required this.storeTitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF0F172A),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF334155), width: 1.2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 26),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    subtext,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF94A3B8),
                      letterSpacing: 0.2,
                    ),
                  ),
                  Text(
                    storeTitle,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.15,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 11,
                      color: Color(0xFF92400E),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Coming Soon',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF92400E),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
