import 'package:claritask_ai/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LandingHeroSection extends StatelessWidget {
  final VoidCallback onTryDemoTap;

  const LandingHeroSection({super.key, required this.onTryDemoTap});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final isAuthenticated = authState is AuthAuthenticated;

    return ResponsiveContainer(
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 20 : 32,
        vertical: context.isMobile ? 36 : 64,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Announcement Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF243B6B).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: const Color(0xFF243B6B).withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    size: 10,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Powered by Cognitive AI • Now Available on Web',
                  style: TextStyle(
                    fontSize: context.isMobile ? 12 : 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF243B6B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Main Headline
          Text(
            'Turn Overwhelming Tasks',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.isMobile ? 32 : (context.isTablet ? 46 : 56),
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0F172A),
              height: 1.15,
              letterSpacing: -1.2,
            ),
          ),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF243B6B), Color(0xFF10B981), Color(0xFF6366F1)],
            ).createShader(bounds),
            child: Text(
              'Into Clear, Actionable Steps.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.isMobile ? 32 : (context.isTablet ? 46 : 56),
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.15,
                letterSpacing: -1.2,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Subtitle
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'ClariTask AI deconstructs ambitious projects, study sessions, complex code architectures, and daily to-dos into frictionless micro-actions. Say goodbye to task paralysis and hello to momentum.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.isMobile ? 15 : 18,
                color: const Color(0xFF64748B),
                height: 1.6,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 36),

          // CTA Buttons
          Wrap(
            spacing: 16,
            runSpacing: 14,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (isAuthenticated) {
                    context.go('/home');
                  } else {
                    context.push('/auth');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F172A),
                  foregroundColor: Colors.white,
                  minimumSize: Size.zero,
                  elevation: 4,
                  shadowColor: const Color(0xFF0F172A).withValues(alpha: 0.3),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.isMobile ? 24 : 32,
                    vertical: context.isMobile ? 16 : 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isAuthenticated ? 'Launch Dashboard' : 'Get Started Free',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 18),
                  ],
                ),
              ),
              OutlinedButton.icon(
                onPressed: onTryDemoTap,
                icon: const Icon(Icons.play_circle_outline_rounded, size: 20),
                label: const Text('Try Live Demo'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF1E293B),
                  side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: context.isMobile ? 20 : 26,
                    vertical: context.isMobile ? 16 : 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Trust Social Proof Chips
          Wrap(
            spacing: 24,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFF59E0B),
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '4.9/5 Rating',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF334155),
                    ),
                  ),
                ],
              ),
              _buildTrustBadge(Icons.bolt_rounded, 'Instant AI breakdown'),
              _buildTrustBadge(Icons.credit_card_off_rounded, 'No credit card needed'),
              _buildTrustBadge(Icons.devices_rounded, 'Synced across Web & Mobile'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrustBadge(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: const Color(0xFF10B981)),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
