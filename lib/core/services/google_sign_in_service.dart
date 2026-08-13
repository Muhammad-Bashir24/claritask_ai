import 'dart:io';

import 'package:claritask_ai/app/constants/app_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static Future<void> init() async {
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
      return; // google_sign_in is not supported on Windows/Linux natively.
    }

    String? clientId;
    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      clientId = AppKeys.iosClientId;
    }

    final actualClientId = (clientId != null && clientId.contains('YOUR_'))
        ? null
        : clientId;
    final actualServerClientId = AppKeys.webClientId.contains('YOUR_')
        ? null
        : AppKeys.webClientId;

    await GoogleSignIn.instance.initialize(
      clientId: actualClientId,
      serverClientId: actualServerClientId,
    );
  }

  static GoogleSignIn get googleSignIn => GoogleSignIn.instance;
}
