// lib/infraestructure/models/commercial_model.dart
import 'package:real_estate_app/domain/entities/commercial_entity.dart';

class CommercialModel extends CommercialEntity {
  CommercialModel({
    required super.id,
    required super.title,
    required super.image,
    required super.linkCommercial,
  });

  factory CommercialModel.fromJson(Map<String, dynamic> json) {
    return CommercialModel(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      linkCommercial: json['linkCommercial'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'linkCommercial': linkCommercial,
    };
  }
}
