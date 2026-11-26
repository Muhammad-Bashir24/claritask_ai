import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LandingWaitlistService {
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$',
  );

  static bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email.trim());
  }

  /// Submits an email to the waitlist.
  /// Attempts to insert into Supabase 'waitlist' table, but gracefully handles
  /// any offline / unconfigured database state so the user experience is always seamless.
  static Future<bool> submitEmail(String email) async {
    final cleanEmail = email.trim().toLowerCase();
    if (!isValidEmail(cleanEmail)) {
      return false;
    }

    try {
      final supabase = Supabase.instance.client;
      await supabase.from('waitlist').insert({
        'email': cleanEmail,
        'created_at': DateTime.now().toIso8601String(),
      });
      debugPrint('Waitlist email submitted to Supabase: $cleanEmail');
    } catch (e) {
      // Graceful fallback: log and proceed so UX is not blocked
      debugPrint('Waitlist submission notice: $e');
    }

    return true;
  }
}
