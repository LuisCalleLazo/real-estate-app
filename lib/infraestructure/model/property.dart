// lib/models/property.dart

import 'package:latlong2/latlong.dart';

enum PropertyType { sale, rent }

class Property {
  final String id;
  final String title;
  final String price;
  final PropertyType type;
  final LatLng location;
  final int bedrooms;
  final int bathrooms;
  final String area;
  final List<String> images;
  final String tour360Url;
  final String description;

  Property({
    required this.id,
    required this.title,
    required this.price,
    required this.type,
    required this.location,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.images,
    required this.tour360Url,
    required this.description,
  });

  // Método para convertir desde JSON (útil para tu backend)
  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      price: json['price'] ?? '',
      type: json['type'] == 'rent' ? PropertyType.rent : PropertyType.sale,
      location: LatLng(
        json['latitude'] ?? 0.0,
        json['longitude'] ?? 0.0,
      ),
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      area: json['area'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      tour360Url: json['tour360Url'] ?? '',
      description: json['description'] ?? '',
    );
  }

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'type': type == PropertyType.rent ? 'rent' : 'sale',
      'latitude': location.latitude,
      'longitude': location.longitude,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'images': images,
      'tour360Url': tour360Url,
      'description': description,
    };
  }
}