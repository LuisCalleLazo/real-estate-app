import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseDatabaseService {
  late final DatabaseReference _database;

  FirebaseDatabaseService({String? databaseURL}) {
    final url = databaseURL ?? dotenv.env['FB_DB_REALTIME'];

    if (url == null || url.isEmpty) {
      throw Exception('Firebase Database URL no está configurada');
    }
    _database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: url,
    ).ref();
  }

  DatabaseReference get database => _database;

  Future<void> writeData(String path, Map<String, dynamic> data) async {
    await _database.child(path).set(data);
  }

  Future<DataSnapshot> readData(String path) async {
    final snapshot = await _database.child(path).get();
    return snapshot;
  }

  Stream<DatabaseEvent> listenToChanges(String path) {
    return _database.child(path).onValue;
  }

  Future<void> updateData(String path, Map<String, dynamic> data) async {
    await _database.child(path).update(data);
  }

  Future<void> deleteData(String path) async {
    await _database.child(path).remove();
  }
}
