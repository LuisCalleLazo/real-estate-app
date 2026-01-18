import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return FirebaseOptions(
        apiKey: DotEnv().env['FB_DB_API_KEY']!,
        authDomain: DotEnv().env['FB_DB_AUTH_DOMAIN']!,
        projectId: DotEnv().env['FB_DB_PROJECT_ID']!,
        storageBucket: DotEnv().env['FB_DB_STORAGE_BUCKET']!,
        messagingSenderId: DotEnv().env['FB_DB_MESSAGING_SENDER_ID']!,
        appId: DotEnv().env['FB_DB_APP_ID']!,
      );
    }

    // Android, iOS, macOS, etc.
    return FirebaseOptions(
      apiKey: DotEnv().env['FB_DB_API_KEY']!,
      appId: DotEnv().env['FB_DB_APP_ID']!,
      messagingSenderId: DotEnv().env['FB_DB_MESSAGING_SENDER_ID']!,
      projectId: DotEnv().env['FB_DB_PROJECT_ID']!,
      storageBucket: DotEnv().env['FB_DB_STORAGE_BUCKET']!,
    );
  }
}
