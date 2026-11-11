import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppKeys {
  // Compile-time environment variables (supported via --dart-define or --dart-define-from-file)
  static const String _envSupabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const String _envSupabaseAnonKey =
      String.fromEnvironment('SUPABASE_ANON_KEY');
  static const String _envWebClientId = String.fromEnvironment('WEB_CLIENT_ID');
  static const String _envIosClientId = String.fromEnvironment('IOS_CLIENT_ID');

  /// Supabase project URL
  static String get supabaseUrl {
    if (_envSupabaseUrl.isNotEmpty) return _envSupabaseUrl;
    if (dotenv.isInitialized) return dotenv.env['SUPABASE_URL'] ?? '';
    return '';
  }

  /// Supabase public anonymous API key
  static String get supabaseAnonKey {
    if (_envSupabaseAnonKey.isNotEmpty) return _envSupabaseAnonKey;
    if (dotenv.isInitialized) return dotenv.env['SUPABASE_ANON_KEY'] ?? '';
    return '';
  }

  /// Web OAuth Client ID (optional)
  static String get webClientId {
    if (_envWebClientId.isNotEmpty) return _envWebClientId;
    if (dotenv.isInitialized) return dotenv.env['WEB_CLIENT_ID'] ?? '';
    return '';
  }

  /// iOS OAuth Client ID (optional)
  static String get iosClientId {
    if (_envIosClientId.isNotEmpty) return _envIosClientId;
    if (dotenv.isInitialized) return dotenv.env['IOS_CLIENT_ID'] ?? '';
    return '';
  }
}
