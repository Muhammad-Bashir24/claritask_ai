import 'package:claritask_ai/app/constants/app_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static Future<void> init() async {
    final url = AppKeys.supabaseUrl;
    final anonKey = AppKeys.supabaseAnonKey;

    if (url.isEmpty || anonKey.isEmpty) {
      throw StateError(
        'Supabase configuration is missing. '
        'Check SUPABASE_URL and SUPABASE_ANON_KEY.',
      );
    }

    await Supabase.initialize(
      url: url,
      // ignore: deprecated_member_use
      anonKey: anonKey,
    );

    debugPrint('Supabase initialized successfully.');
  }

  static SupabaseClient get client => Supabase.instance.client;
}
