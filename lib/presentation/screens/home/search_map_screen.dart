import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/domain/entities/map_zone_user.dart';
import 'package:real_estate_app/domain/entities/property_marker.dart';
import 'package:real_estate_app/presentation/provider/theme_notifier.dart';
import 'package:real_estate_app/presentation/screens/property/filters_map_property_screen.dart';
import 'package:real_estate_app/presentation/widgets/dialog/credit_calculator_dialog.dart';
import 'package:real_estate_app/presentation/widgets/input/search_filter_input.dart';
import 'package:real_estate_app/presentation/widgets/label/zone_map_label.dart';
import 'package:real_estate_app/presentation/widgets/marker/property_item_marker.dart';
import 'package:real_estate_app/presentation/widgets/panel/property_panel.dart';
import 'package:real_estate_app/shared/constants/positions_marker.dart';
import 'package:real_estate_app/shared/utils/side_panel.dart';

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
            },
          ),
          children: [
            TileLayer(
              urlTemplate: _getTileUrl(isDarkMode),
              userAgentPackageName: 'com.inmobol.app',
              tileBuilder: isDarkMode ? _darkTileBuilder : null,
            ),

            PolygonLayer(polygons: buildZonePolygons(zones)),

            MarkerLayer(
              markers: [
                ...positionsMarker.map((property) {
                  return Marker(
                    point: property.position,
                    width: 36,
                    height: 36,
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

                ...buildNameZoneMarkers(zones),
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
              onFiltersChanged: (filters) {},
              showFilterDialog: () {
                sidePanel(
                  context: context,
                  content: FiltersMapPropertyScreen(
                    onFiltersChanged: (filters) {
                      print('Zonas: ${filters['zones']}');
                      print('Bancos: ${filters['banks']}');
                      print('Precio mín: ${filters['priceRange']['min']}');
                      print('Precio máx: ${filters['priceRange']['max']}');

                      // Aplica los filtros a tu mapa
                      // Por ejemplo, filtra positionsMarker según los criterios
                    },
                  ),
                  label: "Filtros",
                );
              },
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
                // print('Datos del formulario: $result');
              }
            },
            child: const Icon(Icons.calculate),
          ),
        ),
      ],
    );
  }

  List<Polygon> buildZonePolygons(List<MapZoneUser> zones) {
    return zones.map((zone) {
      return Polygon(
        points: zone.points,
        color: zone.color.withValues(alpha: 0.5),
        borderColor: zone.color,
        borderStrokeWidth: 1,
      );
    }).toList();
  }

  List<Marker> buildNameZoneMarkers(List<MapZoneUser> zones) {
    return zones.map((zone) {
      return Marker(
        point: getPolygonCenter(zone.points),
        width: 120,
        height: 40,
        child: ZoneMapLabel(name: zone.name),
      );
    }).toList();
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
