import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService {
  final DatabaseReference _database;

  FirebaseDatabaseService() : _database = FirebaseDatabase.instance.ref();

  DatabaseReference get database => _database;

  Future<void> writeData(String path, Map<String, dynamic> data) async {
    await _database.child(path).set(data);
  }

  Future<DataSnapshot> readData(String path) async {
    return await _database.child(path).get();
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

final firebaseDatabaseService = FirebaseDatabaseService();
