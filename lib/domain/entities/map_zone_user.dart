import 'package:flutter/animation.dart';
import 'package:latlong2/latlong.dart';

class MapZoneUser {
  final String name;
  final List<LatLng> points;
  final Color color;

  const MapZoneUser({
    required this.name,
    required this.points,
    required this.color,
  });
}
