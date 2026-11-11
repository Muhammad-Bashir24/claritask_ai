import 'package:claritask_ai/app/constants/app_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static Future<void> init() async {
    final url = AppKeys.supabaseUrl;
    final anonKey = AppKeys.supabaseAnonKey;

    if (url.isEmpty || anonKey.isEmpty) {
      debugPrint(
        'Warning: Supabase URL or Anon Key is missing. '
        'Ensure .env is configured or pass --dart-define / --dart-define-from-file.',
      );
      return;
    }

    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
