// lib/presentation/screens/home/search_map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/domain/entities/property_marker.dart';
import 'package:real_estate_app/presentation/provider/theme_notifier.dart';
import 'package:real_estate_app/presentation/widgets/button/action_button.dart';
import 'package:real_estate_app/presentation/widgets/input/search_filter_input.dart';
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
  final List<LatLng> polygonPoints = positionsMarker
      .map((m) => m.position)
      .toList();

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
            onTap: (_, __) {
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

            PolygonLayer(
              polygons: [
                Polygon(
                  points: polygonPoints,
                  borderStrokeWidth: 1,
                  color: Colors.orangeAccent.withValues(alpha: 0.4),
                ),
              ],
            ),
            MarkerLayer(
              markers: positionsMarker.map((property) {
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
                    child: _buildPropertyMarker(property, isDarkMode),
                  ),
                );
              }).toList(),
            ),
          ],
        ),

        // Búsqueda y filtros en la parte superior
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
            child: _buildPropertyPanel(_selectedProperty!),
          ),

        Positioned(
          right: 16,
          top: 200,
          child: FloatingActionButton.small(
            heroTag: 'location',
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Theme.of(context).iconTheme.color,
            onPressed: () {
              _mapController.move(_center, 13);
            },
            child: const Icon(Icons.my_location),
          ),
        ),
      ],
    );
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

  Widget _buildPropertyMarker(PropertyMarker property, bool isDarkMode) {
    final isSelected = _selectedProperty?.id == property.id;

    if (property.type == MarkerType.poi) {
      // Marcador para puntos de interés (escuelas, etc)
      return Icon(
        Icons.place,
        color: Colors.amber,
        size: isSelected ? 40 : 32,
        shadows: const [
          Shadow(color: Colors.black38, blurRadius: 4, offset: Offset(0, 2)),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Precio
        if (property.price != null)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFF38118)
                  : isDarkMode
                  ? const Color(0xFF2C2C2C)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFF38118),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDarkMode ? 0.5 : 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              property.price!,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFFF38118),
                fontWeight: FontWeight.bold,
                fontSize: isSelected ? 12 : 11,
              ),
            ),
          ),
        const SizedBox(height: 4),
        // Pin
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            Icons.location_on,
            color: const Color(0xFFF38118),
            size: isSelected ? 40 : 32,
            shadows: const [
              Shadow(
                color: Colors.black38,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyPanel(PropertyMarker property) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              height: 120,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: Image.network(
                'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.home,
                      size: 48,
                      color: Colors.grey.shade400,
                    ),
                  );
                },
              ),
            ),
          ),

          // Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        property.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    if (property.price != null)
                      Text(
                        property.price!,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: const Color(0xFFF38118),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.bed, size: 16),
                    const SizedBox(width: 4),
                    const Text('3'),
                    const SizedBox(width: 16),
                    const Icon(Icons.bathroom, size: 16),
                    const SizedBox(width: 4),
                    const Text('2'),
                    const SizedBox(width: 16),
                    const Icon(Icons.square_foot, size: 16),
                    const SizedBox(width: 4),
                    const Text('180m²'),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: ActionButton(
                    text: "Ver detalles",
                    width: MediaQuery.of(context).size.width * 0.8,
                    onPressed: () {
                      context.go('/property');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
