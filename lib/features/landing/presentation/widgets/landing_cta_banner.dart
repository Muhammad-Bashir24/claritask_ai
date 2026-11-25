import 'package:claritask_ai/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LandingCtaBanner extends StatelessWidget {
  const LandingCtaBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final isAuthenticated = authState is AuthAuthenticated;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: context.isMobile ? 48 : 80,
        horizontal: 20,
      ),
      child: ResponsiveContainer(
        maxWidth: 1040,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.isMobile ? 24 : 56,
            vertical: context.isMobile ? 36 : 60,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F172A).withValues(alpha: 0.15),
                blurRadius: 28,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            children: [
              // Headline (from Brief Section 8 & 10)
              Text(
                'Your next task doesn’t have to feel overwhelming.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.isMobile ? 24 : 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.6,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 16),

              // Description (from Brief Section 8 & 10)
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  'Start with what you need to get done. Let ClariTaskAI help you figure out the steps.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.isMobile ? 15 : 17,
                    color: const Color(0xFFCBD5E1),
                    height: 1.55,
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // CTA Button (from Brief Section 8 & 10)
              ElevatedButton(
                onPressed: () {
                  if (isAuthenticated) {
                    context.go('/home');
                  } else {
                    context.push('/auth');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0F172A),
                  minimumSize: Size.zero,
                  padding: EdgeInsets.symmetric(
                    horizontal: context.isMobile ? 28 : 36,
                    vertical: context.isMobile ? 14 : 18,
                  ),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isAuthenticated ? 'Go to Dashboard' : 'Get Started',
                      style: TextStyle(
                        fontSize: context.isMobile ? 15 : 16,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: Color(0xFF0F172A),
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
