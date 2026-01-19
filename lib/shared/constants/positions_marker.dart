import 'package:latlong2/latlong.dart';
import 'package:real_estate_app/domain/entities/property_marker.dart';

final List<PropertyMarker> positionsMarker = [
  PropertyMarker(
    id: '1',
    title: 'Property 1',
    position: LatLng(-16.5447, -68.0736),
    price: 240000,
    type: MarkerType.terrain,
  ),
  PropertyMarker(
    id: '2',
    title: 'Property 2',
    position: LatLng(-16.5186, -68.1289),
    price: 150000,
    type: MarkerType.office,
  ),
  PropertyMarker(
    id: '3',
    title: 'Property 3',
    position: LatLng(-16.5025, -68.1193),
    price: 150000,
    type: MarkerType.store,
  ),
  PropertyMarker(
    id: '4',
    title: 'School',
    position: LatLng(-16.5100, -68.1100),
    price: null,
    type: MarkerType.bank,
  ),
  PropertyMarker(
    id: '5',
    title: 'Contact Plaza',
    position: LatLng(-16.5300, -68.1250),
    price: null,
    type: MarkerType.home,
  ),
];

final List<LatLng> zone1Markers = [
  LatLng(-16.51620724249184, -68.13591601468956),
  LatLng(-16.525115484950557, -68.1358751522146),
  LatLng(-16.519899029192313, -68.12435923114813),
  LatLng(-16.514958348782834, -68.12396344889072),
];
final List<LatLng> zone2Markers = [
  LatLng(-16.51515821979338, -68.12376494603359),
  LatLng(-16.51983222049942, -68.12404806461005),
  LatLng(-16.525342208044147, -68.13555960755419),
  LatLng(-16.543329511620154, -68.11268566969947),
  LatLng(-16.539240299892743, -68.09686897314589),
  LatLng(-16.526164873109483, -68.09455674081315),
  LatLng(-16.50741647380039, -68.11122775497105),
];
final List<LatLng> zone3Markers = [
  LatLng(-16.514917283087325, -68.12390154345526),
  LatLng(-16.51517472996252, -68.12853272124164),
  LatLng(-16.499522735882937, -68.12147869056533),
  LatLng(-16.507426548205473, -68.11161624036038),
];
