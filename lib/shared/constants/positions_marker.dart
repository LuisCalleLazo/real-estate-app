import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_estate_app/domain/entities/map_zone_user.dart';
import 'package:real_estate_app/domain/entities/property_marker.dart';

final List<PropertyMarker> positionsMarker = [
  // ZONA 1 - 6 marcadores (área norte-oriental)
  PropertyMarker(
    id: '1',
    title: 'Casa en Zona 1 Norte',
    position: LatLng(-16.5205, -68.1300),
    price: 280000,
    type: MarkerType.home,
  ),
  PropertyMarker(
    id: '2',
    title: 'Banco Regional Zona 1',
    position: LatLng(-16.5220, -68.1280),
    price: null,
    type: MarkerType.bank,
  ),
  PropertyMarker(
    id: '3',
    title: 'Oficina Corporativa Zona 1',
    position: LatLng(-16.5180, -68.1295),
    price: 350000,
    type: MarkerType.office,
  ),
  PropertyMarker(
    id: '4',
    title: 'Terreno Residencial Zona 1',
    position: LatLng(-16.5230, -68.1260),
    price: 150000,
    type: MarkerType.terrain,
  ),
  PropertyMarker(
    id: '5',
    title: 'Tienda Local Zona 1',
    position: LatLng(-16.5195, -68.1270),
    price: 120000,
    type: MarkerType.store,
  ),
  PropertyMarker(
    id: '6',
    title: 'Casa Familiar Zona 1',
    position: LatLng(-16.5210, -68.1315),
    price: 225000,
    type: MarkerType.home,
  ),

  // ZONA 2 - 10 marcadores (área central más grande)
  PropertyMarker(
    id: '7',
    title: 'Casa Campestre Zona 2',
    position: LatLng(-16.5250, -68.1200),
    price: 420000,
    type: MarkerType.home,
  ),
  PropertyMarker(
    id: '8',
    title: 'Banco Nacional Zona 2',
    position: LatLng(-16.5300, -68.1150),
    price: null,
    type: MarkerType.bank,
  ),
  PropertyMarker(
    id: '9',
    title: 'Centro Comercial Zona 2',
    position: LatLng(-16.5320, -68.1050),
    price: 680000,
    type: MarkerType.store,
  ),
  PropertyMarker(
    id: '10',
    title: 'Oficina Ejecutiva Zona 2',
    position: LatLng(-16.5350, -68.1000),
    price: 450000,
    type: MarkerType.office,
  ),
  PropertyMarker(
    id: '11',
    title: 'Casa Moderna Zona 2',
    position: LatLng(-16.5280, -68.1100),
    price: 315000,
    type: MarkerType.home,
  ),
  PropertyMarker(
    id: '12',
    title: 'Terreno Comercial Zona 2',
    position: LatLng(-16.5400, -68.0900),
    price: 280000,
    type: MarkerType.terrain,
  ),
  PropertyMarker(
    id: '13',
    title: 'Banco del Pueblo Zona 2',
    position: LatLng(-16.5220, -68.0950),
    price: null,
    type: MarkerType.bank,
  ),
  PropertyMarker(
    id: '14',
    title: 'Edificio Corporativo Zona 2',
    position: LatLng(-16.5150, -68.1080),
    price: 890000,
    type: MarkerType.terrain,
  ),
  PropertyMarker(
    id: '15',
    title: 'Casa con Vista Zona 2',
    position: LatLng(-16.5180, -68.1180),
    price: 380000,
    type: MarkerType.home,
  ),
  PropertyMarker(
    id: '16',
    title: 'Restaurante Zona 2',
    position: LatLng(-16.5100, -68.1110),
    price: null,
    type: MarkerType.office,
  ),

  // ZONA 3 - 4 marcadores (área sur-occidental)
  PropertyMarker(
    id: '17',
    title: 'Casa Económica Zona 3',
    position: LatLng(-16.5120, -68.1200),
    price: 165000,
    type: MarkerType.home,
  ),
  PropertyMarker(
    id: '18',
    title: 'Banco Central Zona 3',
    position: LatLng(-16.5080, -68.1150),
    price: null,
    type: MarkerType.bank,
  ),
  PropertyMarker(
    id: '19',
    title: 'Oficina Médica Zona 3',
    position: LatLng(-16.5050, -68.1180),
    price: 295000,
    type: MarkerType.office,
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

final zones = [
  MapZoneUser(name: 'Sopocachi', points: zone1Markers, color: Colors.orange),
  MapZoneUser(name: 'San Pedro', points: zone2Markers, color: Colors.red),
  MapZoneUser(name: 'Miraflores', points: zone3Markers, color: Colors.yellow),
];
