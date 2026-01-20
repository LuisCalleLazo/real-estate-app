import 'package:latlong2/latlong.dart';

enum MarkerType { home, departament, terrain, office, bank, store }

class PropertyMarker {
  final String id;
  final String title;
  final LatLng position;
  final double? price;
  final MarkerType type;

  PropertyMarker({
    required this.id,
    required this.title,
    required this.position,
    this.price,
    this.type = MarkerType.home,
  });
}
