import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return FirebaseOptions(
      apiKey: dotenv.env['FB_DB_API_KEY']!,
      authDomain: dotenv.env['FB_DB_AUTH_DOMAIN']!,
      projectId: dotenv.env['FB_DB_PROJECT_ID']!,
      storageBucket: dotenv.env['FB_DB_STORAGE_BUCKET']!,
      messagingSenderId: dotenv.env['FB_DB_MESSAGING_SENDER_ID']!,
      appId: dotenv.env['FB_DB_APP_WEB_ID']!,
    );
  }
}
