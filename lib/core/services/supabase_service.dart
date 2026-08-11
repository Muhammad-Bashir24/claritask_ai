import 'package:claritask_ai/app/constants/app_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static Future<void> init() async {
    await Supabase.initialize(
      url: AppKeys.supabaseUrl,
      anonKey: AppKeys.supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}