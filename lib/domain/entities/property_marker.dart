import 'package:latlong2/latlong.dart';

enum MarkerType { property, poi }

class PropertyMarker {
  final String id;
  final String title;
  final LatLng position;
  final String? price;
  final MarkerType type;

  PropertyMarker({
    required this.id,
    required this.title,
    required this.position,
    this.price,
    this.type = MarkerType.property,
  });
}
