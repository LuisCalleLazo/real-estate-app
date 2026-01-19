import 'dart:io';

import 'package:flutter/material.dart';
import 'package:real_estate_app/domain/entities/property_entity.dart';
import 'package:real_estate_app/infraestructure/database/firebase_database.dart';
import 'package:real_estate_app/infraestructure/di/get_it.dart';
import 'package:real_estate_app/infraestructure/model/property_model.dart';
import 'package:real_estate_app/infraestructure/services/cloudinary_service.dart';

class PropertyProvider extends ChangeNotifier {
  bool _isCreating = false;
  bool _isLoadingData = false;

  List<PropertyEntity> _properties = [];

  bool get isCreating => _isCreating;
  bool get isLoadingData => _isLoadingData;
  List<PropertyEntity> get properties => _properties;

  Future<void> addProperty(
    String title,
    String description,
    String location,
    double price,
    String type,
    String category,
    String typePayment,
    String zone,
    int bedrooms,
    int bathrooms,
    int parkingLots,
    int kitchens,
    List<File> images,
  ) async {
    _setCreating(true);

    try {
      final cloudinary = getIt<CloudinaryService>();
      final firebase = getIt<FirebaseDatabaseService>();

      // 1️⃣ Subir imágenes
      final List<String> urls = await cloudinary.uploadImages(images);

      // 2️⃣ Crear modelo
      final property = PropertyModel(
        id : (DateTime.now().millisecondsSinceEpoch).toString(),
        title: title,
        description: description,
        ubication: location,
        isFavorite: false,
        latitude: "0",
        longitude: "0",
        price: price,
        typePay: typePayment,
        type: type,
        area: zone,
        group: category,
        bathrooms: bathrooms,
        parkingLots: parkingLots,
        kitchens: kitchens,
        bedrooms: bedrooms,
        photos: urls,
      );

      // 3️⃣ Guardar en Firebase
      await firebase.writeData("properties/${property.id}", property.toJson());
    } catch (e) {
      rethrow;
    } finally {
      _setCreating(false);
    }
  }

  Future<void> loadData() async {
    _isLoadingData = true;
    notifyListeners();

    final firebase = getIt<FirebaseDatabaseService>();
    final snapshot = await firebase.readData("properties");

    final List<PropertyEntity> loaded = [];

    if (snapshot.exists && snapshot.value != null) {
      final map = snapshot.value as Map<dynamic, dynamic>;

      map.forEach((key, value) {
        loaded.add(
          PropertyModel.fromFirebase(
            key.toString(),
            Map<dynamic, dynamic>.from(value),
          ),
        );
      });
    }

    _properties = loaded;
    _isLoadingData = false;
    notifyListeners();
  }

  void _setCreating(bool value) {
    _isCreating = value;
    notifyListeners();
  }
}
