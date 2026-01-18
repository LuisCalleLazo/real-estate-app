import 'package:real_estate_app/infraestructure/database/firebase_database.dart';

extension FirebaseDatabaseCollections on FirebaseDatabaseService {
  Future<void> initCollection(
    String path,
    List<Map<String, dynamic>> initialData,
  ) async {
    final snapshot = await readData(path);
    if (!snapshot.exists) {
      for (var data in initialData) {
        await database.child(path).push().set(data);
      }
    }
  }

  // Escribir un modelo directamente
  Future<void> writeModel(String path, Map<String, dynamic> modelData) async {
    await writeData(path, modelData);
  }

  // Leer lista de modelos
  Future<List<T>> readCollection<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final snapshot = await readData(path);
    if (!snapshot.exists) return [];
    final dataMap = snapshot.value as Map<dynamic, dynamic>;
    return dataMap.values
        .map((e) => fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  // Escuchar cambios en tiempo real y mapear a modelo
  Stream<List<T>> listenCollection<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return listenToChanges(path).map((event) {
      if (event.snapshot.exists) {
        final dataMap = event.snapshot.value as Map<dynamic, dynamic>;
        return dataMap.values
            .map((e) => fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
      return <T>[];
    });
  }
}
