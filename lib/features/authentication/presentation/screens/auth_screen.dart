import 'package:claritask_ai/core/utils/custom_toast.dart';
import 'package:claritask_ai/core/utils/validators.dart';
import 'package:claritask_ai/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:claritask_ai/core/di/injection.dart';
import 'package:claritask_ai/features/personalization/domain/usecases/check_onboarding_status.dart';
import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginWithEmail() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final emailError = Validators.email(email);
    if (emailError != null) {
      CustomToast.show(
        context: context,
        message: emailError,
        type: ToastType.error,
      );
      return;
    }

    if (password.isEmpty) {
      CustomToast.show(
        context: context,
        message: 'Password is required',
        type: ToastType.error,
      );
      return;
    }

    context.read<AuthCubit>().loginWithEmail(email, password);
  }

  void _loginWithGoogle() {
    context.read<AuthCubit>().loginWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is AuthAuthenticated) {
          final checkOnboarding = sl<CheckOnboardingStatusUseCase>();
          final result = await checkOnboarding();
          if (!context.mounted) return;
          result.fold((failure) => context.go('/home'), (isCompleted) {
            if (isCompleted) {
              context.go('/home');
            } else {
              context.go('/personalization');
            }
          });
        } else if (state is AuthPasswordRecovery) {
          context.go('/update-password');
        } else if (state is AuthError) {
          CustomToast.show(
            context: context,
            message: state.message,
            type: ToastType.error,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFFAFAFC),
          body: SafeArea(
            child: context.isWide
                ? _buildDesktopLayout(state)
                : _buildMobileTabletLayout(state),
          ),
        );
      },
    );
  }

  // Desktop Split-Screen Layout (Width >= 900px)
  Widget _buildDesktopLayout(AuthState state) {
    return Row(
      children: [
        // Left Branding Hero Banner
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.all(56),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0F172A),
                  Color(0xFF1E293B),
                  Color(0xFF1E3A8A),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Logo
                InkWell(
                  onTap: () {
                    if (kIsWeb) context.go('/landing');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          'assets/images/Claritask_ai_logo-removebg-preview.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.auto_awesome,
                            color: Color(0xFF0F172A),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'ClariTask AI',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Middle Pitch
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bolt, size: 14, color: Color(0xFF34D399)),
                          SizedBox(width: 6),
                          Text(
                            'COGNITIVE TASK ASSISTANT',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Turn Big Ambitions\nInto Clear Momentum.',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.2,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Say goodbye to procrastination and dread. ClariTask AI instantly decomposes complex code architectures, study roadmaps, and business goals into bite-sized achievable steps.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFCBD5E1),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildFeatureBullet(
                      Icons.auto_awesome,
                      'Instant Cognitive Deconstruction',
                      'Transform raw thoughts into sequenced micro-steps in seconds.',
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureBullet(
                      Icons.adjust_rounded,
                      'Single-Step Focus',
                      'Eliminate overwhelm by focusing exclusively on what is next.',
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureBullet(
                      Icons.sync_rounded,
                      'Full Web & Mobile Sync',
                      'Pick up right where you left off from your browser or phone.',
                    ),
                  ],
                ),

                // Bottom Quote
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.12),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.format_quote_rounded,
                        color: Color(0xFF34D399),
                        size: 28,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '"ClariTask cured my Monday morning task paralysis."',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Right Auth Card Form
        Expanded(
          flex: 6,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: _buildFormCard(state),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureBullet(IconData icon, String title, String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF34D399), size: 16),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF94A3B8),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Mobile & Tablet Responsive Layout
  Widget _buildMobileTabletLayout(AuthState state) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.isTablet ? 40 : 24.w,
          vertical: 24,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            children: [
              if (kIsWeb)
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => context.go('/landing'),
                    icon: const Icon(Icons.arrow_back_rounded, size: 16),
                    label: const Text('Back to Landing Page'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF64748B),
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              // App Logo Card
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  'assets/images/Claritask_ai_logo-removebg-preview.png',
                  color: Colors.white,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Header Title
              const Text(
                'ClariTask AI',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Your cognitive assistant for high-performance task management.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Authentication Card Container
              _buildFormCard(state),
            ],
          ),
        ),
      ),
    );
  }

  // Common Form Card (used in both split and mobile layouts)
  Widget _buildFormCard(AuthState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome back',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Sign in to continue your flow.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),
          // Continue with Google Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: state is AuthLoading ? null : _loginWithGoogle,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFFE2E8F0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/images.jpg',
                    width: 20,
                    height: 20,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.g_mobiledata_rounded,
                      size: 24,
                      color: Color(0xFFEA4335),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Continue with Google',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF334155),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          // Divider
          const Row(
            children: [
              Expanded(child: Divider(color: Color(0xFFE2E8F0))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'or',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ),
              Expanded(child: Divider(color: Color(0xFFE2E8F0))),
            ],
          ),
          const SizedBox(height: 18),
          // Email Field
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email address',
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFF94A3B8),
              ),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF0F172A)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Password Field
          TextField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFF94A3B8),
              ),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: const Color(0xFF94A3B8),
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF0F172A)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => context.push('/forgot-password'),
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF0F172A),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Continue with Email Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: state is AuthLoading ? null : _loginWithEmail,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F172A),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: state is AuthLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Continue with Email',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 20),
          // Create account prompt
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'New here? ',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                ),
              ),
              GestureDetector(
                onTap: () => context.push('/signup'),
                child: const Text(
                  'Create account',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Footer Links
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _AuthFooterLink(title: 'Privacy Policy'),
              _AuthFooterLink(title: 'Terms of Service'),
              _AuthFooterLink(title: 'Help Center'),
            ],
          ),
        ],
      ),
    );
  }
}

class _AuthFooterLink extends StatelessWidget {
  final String title;

  const _AuthFooterLink({required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        title,
        style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
      ),
    );
  }
}
