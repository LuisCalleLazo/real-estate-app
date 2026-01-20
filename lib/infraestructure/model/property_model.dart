// lib/infraestructure/models/property_model.dart
import 'package:real_estate_app/domain/entities/property_entity.dart';

class PropertyModel extends PropertyEntity {
  PropertyModel({
    required super.id,
    required super.title,
    required super.description,
    required super.ubication,
    required super.isFavorite,
    required super.latitude,
    required super.longitude,
    required super.price,
    required super.typePay,
    required super.type,
    required super.area,
    required super.group,
    required super.bathrooms,
    required super.parkingLots,
    required super.kitchens,
    required super.bedrooms,
    required super.photos,
  });

  factory PropertyModel.fromFirebase(String id, Map<dynamic, dynamic> json) {
    return PropertyModel(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      ubication: json['ubication'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      typePay: json['typePay'] ?? '',
      type: json['type'] ?? '',
      area: json['area'] ?? '',
      group: json['group'] ?? '',
      bathrooms: json['bathrooms'] ?? 0,
      parkingLots: json['parkingLots'] ?? 0,
      kitchens: json['kitchens'] ?? 0,
      bedrooms: json['bedrooms'] ?? 0,
      photos: json['photos'] != null ? List<String>.from(json['photos']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'ubication': ubication,
      'isFavorite': isFavorite,
      'latitude': latitude,
      'longitude': longitude,
      'price': price,
      'typePay': typePay,
      'type': type,
      'area': area,
      'group': group,
      'bathrooms': bathrooms,
      'parkingLots': parkingLots,
      'kitchens': kitchens,
      'bedrooms': bedrooms,
      'photos': photos,
    };
  }
}
