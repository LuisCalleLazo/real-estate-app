import 'package:firebase_database/firebase_database.dart';

/// Servicio para interactuar con Firebase Realtime Database
class FirebaseDatabaseService {
  final DatabaseReference _database;

  FirebaseDatabaseService() : _database = FirebaseDatabase.instance.ref();

  /// Obtiene la referencia a la base de datos
  DatabaseReference get database => _database;

  /// Escribe datos en la base de datos
  Future<void> writeData(String path, Map<String, dynamic> data) async {
    await _database.child(path).set(data);
  }

  /// Lee datos de la base de datos una vez
  Future<DataSnapshot> readData(String path) async {
    return await _database.child(path).get();
  }

  /// Escucha cambios en tiempo real en una ruta específica
  Stream<DatabaseEvent> listenToChanges(String path) {
    return _database.child(path).onValue;
  }

  /// Actualiza datos en la base de datos
  Future<void> updateData(String path, Map<String, dynamic> data) async {
    await _database.child(path).update(data);
  }

  /// Elimina datos de la base de datos
  Future<void> deleteData(String path) async {
    await _database.child(path).remove();
  }
}

/// Instancia global del servicio de Firebase Database
final firebaseDatabaseService = FirebaseDatabaseService();
