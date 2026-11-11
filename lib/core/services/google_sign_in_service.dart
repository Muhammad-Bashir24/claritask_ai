import 'package:claritask_ai/app/constants/app_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static Future<void> init() async {
    try {
      if (!kIsWeb &&
          (defaultTargetPlatform == TargetPlatform.windows ||
              defaultTargetPlatform == TargetPlatform.linux)) {
        return; // google_sign_in is not supported on Windows/Linux natively.
      }

      String? clientId;
      String? serverClientId;

      if (kIsWeb) {
        // On Web, Google Sign-In requires clientId and serverClientId must be null
        final webId = AppKeys.webClientId;
        if (webId.isNotEmpty && !webId.contains('YOUR_')) {
          clientId = webId;
        } else {
          // If no web client ID is set, skip initialization to avoid GIS assertion failure
          return;
        }
      } else {
        if (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS) {
          final iosId = AppKeys.iosClientId;
          if (iosId.isNotEmpty && !iosId.contains('YOUR_')) {
            clientId = iosId;
          }
        }

        final webId = AppKeys.webClientId;
        if (webId.isNotEmpty && !webId.contains('YOUR_')) {
          serverClientId = webId;
        }
      }

      await GoogleSignIn.instance.initialize(
        clientId: clientId,
        serverClientId: serverClientId,
      );
    } catch (e) {
      debugPrint('GoogleSignInService init warning: $e');
    }
  }

  static GoogleSignIn get googleSignIn => GoogleSignIn.instance;
}
