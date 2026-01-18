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

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      ubication: json['ubication'] as String,
      isFavorite: json['isFavorite'] as bool,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      price: (json['price'] as num).toDouble(),
      typePay: json['typePay'] as String,
      type: json['type'] as String,
      area: json['area'] as String,
      group: json['group'] as String,
      bathrooms: json['bathrooms'] as int,
      parkingLots: json['parkingLots'] as int,
      kitchens: json['kitchens'] as int,
      bedrooms: json['bedrooms'] as int,
      photos: List<String>.from(json['photos'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
