// lib/presentation/screens/home/search_map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/domain/entities/property_marker.dart';
import 'package:real_estate_app/presentation/provider/theme_notifier.dart';
import 'package:real_estate_app/presentation/widgets/dialog/credit_calculator_dialog.dart';
import 'package:real_estate_app/presentation/widgets/input/search_filter_input.dart';
import 'package:real_estate_app/presentation/widgets/marker/property_item_marker.dart';
import 'package:real_estate_app/presentation/widgets/panel/property_panel.dart';
import 'package:real_estate_app/shared/constants/positions_marker.dart';

class SearchMapScreen extends StatefulWidget {
  const SearchMapScreen({super.key});

  @override
  State<SearchMapScreen> createState() => _SearchMapScreenState();
}

class _SearchMapScreenState extends State<SearchMapScreen> {
  final MapController _mapController = MapController();

  final LatLng _center = LatLng(-16.5000, -68.1193);

  PropertyMarker? _selectedProperty;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeNotifier>().isDarkMode;

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _center,
            initialZoom: 13.0,
            minZoom: 10.0,
            maxZoom: 18.0,
            onTap: (tapPosition, latLng) {
              setState(() {
                _selectedProperty = null;
              });

              print(
                'Latitud: ${latLng.latitude}, Longitud: ${latLng.longitude}',
              );

              // _handleMapTap(latLng);
            },
          ),
          children: [
            TileLayer(
              urlTemplate: _getTileUrl(isDarkMode),
              userAgentPackageName: 'com.inmobol.app',
              tileBuilder: isDarkMode ? _darkTileBuilder : null,
            ),

            PolygonLayer(
              polygons: [
                Polygon(
                  points: zone1Markers,
                  color: Colors.orange.withValues(alpha: 0.3),
                ),
                Polygon(
                  points: zone2Markers,
                  color: Colors.red.withValues(alpha: 0.3),
                ),
                Polygon(
                  points: zone3Markers,
                  color: Colors.yellow.withValues(alpha: 0.3),
                ),
              ],
            ),
            MarkerLayer(
              markers: [
                ...positionsMarker.map((property) {
                  return Marker(
                    point: property.position,
                    width: 80,
                    height: 80,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedProperty = property;
                        });
                        _mapController.move(property.position, 15);
                      },
                      child: PropertyItemMarker(
                        property: property,
                        isDarkMode: isDarkMode,
                        selectedProperty: _selectedProperty ?? property,
                      ),
                    ),
                  );
                }),
                Marker(
                  point: getPolygonCenter(zone1Markers),
                  width: 100,
                  height: 40,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      child: const Text(
                        'Sopocachi',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Marker(
                  point: getPolygonCenter(zone2Markers),
                  width: 100,
                  height: 40,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      child: const Text(
                        'San Pedro',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Marker(
                  point: getPolygonCenter(zone3Markers),
                  width: 100,
                  height: 40,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      child: const Text(
                        'Miraflores',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(
                    context,
                  ).scaffoldBackgroundColor.withValues(alpha: 0.0),
                ],
              ),
            ),
            child: SearchFilterInput(
              onSearchChanged: (value) {},
              onFiltersChanged: (values) {},
            ),
          ),
        ),

        if (_selectedProperty != null)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: PropertyPanel(property: _selectedProperty!),
          ),

        Positioned(
          left: 16,
          top: 170,
          child: FloatingActionButton.small(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            heroTag: 'calculate',
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Theme.of(context).iconTheme.color,
            onPressed: () async {
              final result = await showDialog(
                context: context,
                builder: (context) => const CreditCalculatorDialog(),
              );

              if (result != null) {
                // Aquí puedes usar los datos retornados
                print('Datos del formulario: $result');
              }
            },
            child: const Icon(Icons.calculate),
          ),
        ),
      ],
    );
  }

  LatLng getPolygonCenter(List<LatLng> points) {
    double latSum = 0;
    double lngSum = 0;
    for (var point in points) {
      latSum += point.latitude;
      lngSum += point.longitude;
    }
    return LatLng(latSum / points.length, lngSum / points.length);
  }

  String _getTileUrl(bool isDarkMode) {
    if (isDarkMode) {
      return 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png';
    } else {
      return 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
    }
  }

  Widget _darkTileBuilder(
    BuildContext context,
    Widget tileWidget,
    TileImage tile,
  ) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        const Color(0xFFF38118).withValues(alpha: 0.05), // Tinte naranja sutil
        BlendMode.overlay,
      ),
      child: tileWidget,
    );
  }
}
