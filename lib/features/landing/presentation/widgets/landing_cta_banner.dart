import 'package:claritask_ai/features/landing/presentation/widgets/landing_store_buttons.dart';
import 'package:claritask_ai/features/landing/presentation/widgets/landing_waitlist_service.dart';
import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class LandingCtaBanner extends StatefulWidget {
  final VoidCallback onJoinWaitlistTap;

  const LandingCtaBanner({
    super.key,
    required this.onJoinWaitlistTap,
  });

  @override
  State<LandingCtaBanner> createState() => _LandingCtaBannerState();
}

class _LandingCtaBannerState extends State<LandingCtaBanner> {
  final TextEditingController _emailController = TextEditingController();
  bool _isSubmitting = false;
  bool _submittedSuccess = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() => _errorMessage = 'Please enter your email');
      return;
    }
    if (!LandingWaitlistService.isValidEmail(email)) {
      setState(() => _errorMessage = 'Please enter a valid email');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    await LandingWaitlistService.submitEmail(email);

    if (mounted) {
      setState(() {
        _isSubmitting = false;
        _submittedSuccess = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              // Headline
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

              // Description
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 620),
                child: Text(
                  'ClariTaskAI is launching soon on Web, iOS, and Android. Join our early access waitlist to be among the first to turn any task into simple steps.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.isMobile ? 15 : 17,
                    color: const Color(0xFFCBD5E1),
                    height: 1.55,
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // Inline Waitlist Capture Form
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: _submittedSuccess
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF10B981)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle_rounded,
                              color: Color(0xFF10B981),
                              size: 24,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'You’re on the waitlist!',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'We’ll notify ${_emailController.text.trim()} upon launch.',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF94A3B8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: context.isMobile
                                ? Column(
                                    children: [
                                      TextField(
                                        controller: _emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        style: const TextStyle(color: Color(0xFF0F172A)),
                                        textInputAction: TextInputAction.done,
                                        onSubmitted: (_) => _handleSubmit(),
                                        decoration: const InputDecoration(
                                          hintText: 'Enter your email address...',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF94A3B8),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.mail_outline_rounded,
                                            color: Color(0xFF64748B),
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: _isSubmitting
                                              ? null
                                              : _handleSubmit,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF0F172A),
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: _isSubmitting
                                              ? const SizedBox(
                                                  height: 18,
                                                  width: 18,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : const Text(
                                                  'Join Waitlist',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _emailController,
                                          keyboardType: TextInputType.emailAddress,
                                          style: const TextStyle(
                                            color: Color(0xFF0F172A),
                                          ),
                                          textInputAction: TextInputAction.done,
                                          onSubmitted: (_) => _handleSubmit(),
                                          decoration: const InputDecoration(
                                            hintText: 'Enter your email for early access...',
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF94A3B8),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.mail_outline_rounded,
                                              color: Color(0xFF64748B),
                                            ),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: _isSubmitting
                                            ? null
                                            : _handleSubmit,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF0F172A),
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 24,
                                            vertical: 14,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: _isSubmitting
                                            ? const SizedBox(
                                                height: 18,
                                                width: 18,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : const Text(
                                                'Join Waitlist',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                          ),
                          if (_errorMessage != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              _errorMessage!,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFCA5A5),
                              ),
                            ),
                          ],
                        ],
                      ),
              ),
              const SizedBox(height: 36),

              // Store Download Badges (Coming Soon)
              Column(
                children: [
                  const Text(
                    'Also launching on mobile',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  LandingStoreButtons(
                    onNotifyMeTap: widget.onJoinWaitlistTap,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
