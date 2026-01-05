import 'package:latlong2/latlong.dart';
import 'package:real_estate_app/domain/entities/property_marker.dart';

final List<PropertyMarker> positionsMarker = [
  PropertyMarker(
    id: '1',
    title: 'Property 1',
    position: LatLng(-16.5447, -68.0736),
    price: '\$240,000',
  ),
  PropertyMarker(
    id: '2',
    title: 'Property 2',
    position: LatLng(-16.5186, -68.1289),
    price: '\$180,000',
  ),
  PropertyMarker(
    id: '3',
    title: 'Property 3',
    position: LatLng(-16.5025, -68.1193),
    price: '\$150,000',
  ),
  PropertyMarker(
    id: '4',
    title: 'School',
    position: LatLng(-16.5100, -68.1100),
    price: null,
    type: MarkerType.poi,
  ),
  PropertyMarker(
    id: '5',
    title: 'Contact Plaza',
    position: LatLng(-16.5300, -68.1250),
    price: null,
    type: MarkerType.poi,
  ),
];
