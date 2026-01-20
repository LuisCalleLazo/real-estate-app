import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:real_estate_app/infraestructure/database/firebase_database.dart';
import 'package:real_estate_app/infraestructure/di/get_it.dart';

void setupDatabase() {
  getIt.registerLazySingleton<FirebaseDatabaseService>(() {
    if (Firebase.apps.isEmpty) {
      throw Exception(
        'Firebase must be initialized before FirebaseDatabaseService',
      );
    }
    return FirebaseDatabaseService(databaseURL: dotenv.env['FB_DB_REALTIME']);
  });
}
