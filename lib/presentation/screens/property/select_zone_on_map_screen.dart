import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/presentation/provider/theme_notifier.dart';

class ZoneData {
  final Polygon polygon;
  final String name;
  final LatLng center;

  ZoneData({required this.polygon, required this.name, required this.center});
}

class SelectZoneOnMapScreen extends StatefulWidget {
  const SelectZoneOnMapScreen({super.key});

  @override
  State<SelectZoneOnMapScreen> createState() => _SelectZoneOnMapScreenState();
}

class _SelectZoneOnMapScreenState extends State<SelectZoneOnMapScreen> {
  final MapController _mapController = MapController();
  final LatLng _center = LatLng(-16.5000, -68.1193);
  final TextEditingController _zoneNameController = TextEditingController();

  // Variables para el dibujo de polígonos
  List<LatLng> _polygonPoints = [];
  Color _selectedColor = Colors.blue.withValues(alpha: 0.3);
  bool _isDrawingMode = false;
  List<ZoneData> _savedZones = [];

  @override
  void dispose() {
    _zoneNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeNotifier>().isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text("Seleccione la zona que desea tener pendiente"),
        actions: [
          if (_isDrawingMode && _polygonPoints.isNotEmpty)
            IconButton(
              icon: Icon(Icons.undo),
              tooltip: 'Deshacer último punto',
              onPressed: () {
                setState(() {
                  if (_polygonPoints.isNotEmpty) {
                    _polygonPoints.removeLast();
                  }
                });
              },
            ),
          if (_isDrawingMode && _polygonPoints.length >= 3)
            IconButton(
              icon: Icon(Icons.check),
              tooltip: 'Completar polígono',
              onPressed: _completePolygon,
            ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 13.0,
              minZoom: 10.0,
              maxZoom: 18.0,
              onTap: (tapPosition, latLng) {
                if (_isDrawingMode) {
                  setState(() {
                    _polygonPoints.add(latLng);
                  });
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: _getTileUrl(isDarkMode),
                userAgentPackageName: 'com.inmobol.app',
                tileBuilder: isDarkMode ? _darkTileBuilder : null,
              ),
              // Polígonos guardados
              PolygonLayer(
                polygons: _savedZones.map((zone) => zone.polygon).toList(),
              ),
              // Polígono en proceso de dibujo
              if (_polygonPoints.isNotEmpty)
                PolygonLayer(
                  polygons: [
                    Polygon(
                      points: _polygonPoints,
                      color: _selectedColor,
                      borderColor: _selectedColor.withValues(alpha: 1.0),
                      borderStrokeWidth: 1,
                    ),
                  ],
                ),
              // Marcadores para los puntos del polígono en dibujo
              if (_polygonPoints.isNotEmpty)
                MarkerLayer(
                  markers: _polygonPoints.asMap().entries.map((entry) {
                    return Marker(
                      point: entry.value,
                      width: 20,
                      height: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedColor.withValues(alpha: 1.0),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${entry.key + 1}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _selectedColor.withValues(alpha: 1.0),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              // Marcadores con nombres de zonas guardadas
              MarkerLayer(
                markers: _savedZones.map((zone) {
                  return Marker(
                    point: zone.center,
                    width: 150,
                    height: 40,
                    child: GestureDetector(
                      onTap: () => _showZoneOptions(zone),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: zone.polygon.borderColor.withValues(
                            alpha: 0.9,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            zone.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // Panel de controles
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Botón para activar/desactivar modo dibujo
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _isDrawingMode = !_isDrawingMode;
                            if (!_isDrawingMode) {
                              _polygonPoints.clear();
                            }
                          });
                        },
                        icon: Icon(
                          _isDrawingMode ? Icons.close : Icons.edit_location,
                        ),
                        label: Text(
                          _isDrawingMode ? 'Cancelar dibujo' : 'Dibujar zona',
                        ),
                      ),
                    ),

                    if (_isDrawingMode) ...[
                      SizedBox(height: 12),

                      // Selector de color
                      Text(
                        'Seleccione el color de la zona:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: [
                          _colorOption(Colors.blue.withValues(alpha: 0.3)),
                          _colorOption(Colors.red.withValues(alpha: 0.3)),
                          _colorOption(Colors.green.withValues(alpha: 0.3)),
                          _colorOption(Colors.orange.withValues(alpha: 0.3)),
                          _colorOption(Colors.purple.withValues(alpha: 0.3)),
                          _colorOption(Colors.yellow.withValues(alpha: 0.3)),
                          _colorOption(Colors.pink.withValues(alpha: 0.3)),
                          _colorOption(Colors.teal.withValues(alpha: 0.3)),
                        ],
                      ),

                      SizedBox(height: 12),

                      // Información
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline, size: 20),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Toque en el mapa para agregar puntos. Mínimo 3 puntos.',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(
                        'Puntos: ${_polygonPoints.length}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],

                    // Mostrar zonas guardadas
                    if (_savedZones.isNotEmpty) ...[
                      SizedBox(height: 12),
                      Divider(),
                      Text(
                        'Zonas guardadas: ${_savedZones.length}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _confirmClearAllZones();
                          },
                          icon: Icon(Icons.delete_outline),
                          label: Text('Limpiar todas las zonas'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorOption(Color color) {
    final isSelected = _selectedColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: isSelected
            ? Icon(Icons.check, color: Colors.white, size: 20)
            : null,
      ),
    );
  }

  LatLng _calculatePolygonCenter(List<LatLng> points) {
    double latitude = 0;
    double longitude = 0;

    for (var point in points) {
      latitude += point.latitude;
      longitude += point.longitude;
    }

    return LatLng(latitude / points.length, longitude / points.length);
  }

  void _completePolygon() {
    if (_polygonPoints.length >= 3) {
      _zoneNameController.clear();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Guardar zona'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Ingrese el nombre de la zona:'),
              SizedBox(height: 16),
              TextField(
                controller: _zoneNameController,
                decoration: InputDecoration(
                  labelText: 'Nombre de la zona',
                  hintText: 'Ej: Zona Centro, Sopocachi, etc.',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                textCapitalization: TextCapitalization.words,
                autofocus: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final zoneName = _zoneNameController.text.trim();
                if (zoneName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor ingrese un nombre para la zona'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                  return;
                }

                setState(() {
                  final center = _calculatePolygonCenter(_polygonPoints);

                  _savedZones.add(
                    ZoneData(
                      polygon: Polygon(
                        points: List.from(_polygonPoints),
                        color: _selectedColor,
                        borderColor: _selectedColor.withValues(alpha: 1.0),
                        borderStrokeWidth: 1,
                      ),
                      name: zoneName,
                      center: center,
                    ),
                  );
                  _polygonPoints.clear();
                  _isDrawingMode = false;
                });
                Navigator.pop(context);

                // Mostrar mensaje de éxito
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Zona "$zoneName" guardada exitosamente'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      );
    }
  }

  void _showZoneOptions(ZoneData zone) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(zone.name),
        content: Text('¿Qué desea hacer con esta zona?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _editZoneName(zone);
            },
            child: Text('Editar nombre'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteZone(zone);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _editZoneName(ZoneData zone) {
    _zoneNameController.text = zone.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar nombre de zona'),
        content: TextField(
          controller: _zoneNameController,
          decoration: InputDecoration(
            labelText: 'Nombre de la zona',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_on),
          ),
          textCapitalization: TextCapitalization.words,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = _zoneNameController.text.trim();
              if (newName.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Por favor ingrese un nombre para la zona'),
                    backgroundColor: Colors.orange,
                  ),
                );
                return;
              }

              setState(() {
                final index = _savedZones.indexOf(zone);
                _savedZones[index] = ZoneData(
                  polygon: zone.polygon,
                  name: newName,
                  center: zone.center,
                );
              });
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Nombre actualizado'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _deleteZone(ZoneData zone) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar zona'),
        content: Text('¿Está seguro de eliminar la zona "${zone.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _savedZones.remove(zone);
              });
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Zona eliminada'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _confirmClearAllZones() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Limpiar todas las zonas'),
        content: Text('¿Está seguro de eliminar todas las zonas guardadas?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _savedZones.clear();
              });
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Todas las zonas han sido eliminadas'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Eliminar todo'),
          ),
        ],
      ),
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
        const Color(0xFFF38118).withValues(alpha: 0.05),
        BlendMode.overlay,
      ),
      child: tileWidget,
    );
  }
}
