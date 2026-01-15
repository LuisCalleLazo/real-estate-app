import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: "...",
        authDomain: "...",
        projectId: "...",
        storageBucket: "...",
        messagingSenderId: "...",
        appId: "...",
      );
    }

    // Android, iOS, macOS, etc.
    return const FirebaseOptions(
      apiKey: "TU_API_KEY",
      appId: "TU_APP_ID",
      messagingSenderId: "TU_SENDER_ID",
      projectId: "TU_PROJECT_ID",
      storageBucket: "TU_STORAGE_BUCKET",
    );
  }
}
