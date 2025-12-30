// lib/screens/property_map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_estate_app/infraestructure/model/property.dart';
import 'package:real_estate_app/presentation/screens/property_detail_screen.dart';

// Asegúrate de importar el modelo
// import '../models/property.dart';

class PropertyMapScreen extends StatefulWidget {
  
  static const String name = 'property_map_screen';
  const PropertyMapScreen({super.key});

  @override
  State<PropertyMapScreen> createState() => _PropertyMapScreenState();
}

class _PropertyMapScreenState extends State<PropertyMapScreen> {
  final MapController _mapController = MapController();
  Property? _selectedProperty;
  bool _isSatelliteView = false;

  // Propiedades de ejemplo en La Paz, Bolivia
  final List<Property> properties = [
    Property(
      id: '1',
      title: 'Casa en Calacoto',
      price: '\$240,000',
      type: PropertyType.sale,
      location: LatLng(-16.5447, -68.0736),
      bedrooms: 3,
      bathrooms: 2,
      area: '180m²',
      images: [
        'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800',
        'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
        'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800',
      ],
      tour360Url: 'https://kuula.co/share/collection/7lGVt',
      description: 'Hermosa casa en zona residencial de Calacoto',
    ),
    Property(
      id: '2',
      title: 'Departamento en Sopocachi',
      price: '\$120,000',
      type: PropertyType.sale,
      location: LatLng(-16.5186, -68.1289),
      bedrooms: 2,
      bathrooms: 1,
      area: '85m²',
      images: [
        'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
        'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800',
      ],
      tour360Url: 'https://kuula.co/share/collection/7lGVt',
      description: 'Moderno departamento cerca al Montículo',
    ),
    Property(
      id: '3',
      title: 'Casa en San Miguel',
      price: '\$180,000',
      type: PropertyType.sale,
      location: LatLng(-16.5025, -68.1193),
      bedrooms: 4,
      bathrooms: 3,
      area: '220m²',
      images: [
        'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800',
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
      ],
      tour360Url: 'https://kuula.co/share/collection/7lGVt',
      description: 'Amplia casa familiar con jardín',
    ),
    Property(
      id: '4',
      title: 'Departamento en Achumani',
      price: '\$95,000',
      type: PropertyType.rent,
      location: LatLng(-16.5617, -68.0842),
      bedrooms: 2,
      bathrooms: 2,
      area: '95m²',
      images: [
        'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800',
      ],
      tour360Url: 'https://kuula.co/share/collection/7lGVt',
      description: 'Departamento acogedor en zona sur',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Mapa
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(-16.5000, -68.1193), // Centro de La Paz
              initialZoom: 13.0,
              maxZoom: 18.0,
              minZoom: 10.0,
              // Callbacks útiles
              onTap: (tapPosition, point) {
                // Cerrar el panel si se toca el mapa
                if (_selectedProperty != null) {
                  setState(() {
                    _selectedProperty = null;
                  });
                }
              },
            ),
            children: [
              // Capa de mapa (normal o satélite)
              TileLayer(
                urlTemplate: _isSatelliteView
                    ? 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}'
                    : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.inmobol.app',
              ),
              // Capa de marcadores
              MarkerLayer(
                markers: properties.map((property) {
                  return Marker(
                    point: property.location,
                    width: 80,
                    height: 80,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedProperty = property;
                        });
                        _mapController.move(property.location, 15);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Precio
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              property.price,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          // Pin
                          Icon(
                            Icons.location_on,
                            color: property.type == PropertyType.sale
                                ? Colors.orange
                                : Colors.green,
                            size: 36,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(),
          ),

          // Controles del mapa
          Positioned(
            top: 100,
            right: 16,
            child: _buildMapControls(),
          ),

          // Leyenda
          Positioned(
            bottom: _selectedProperty != null ? 280 : 20,
            left: 16,
            child: _buildLegend(),
          ),

          // Panel de propiedad seleccionada
          if (_selectedProperty != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildPropertyPanel(_selectedProperty!),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.blue.shade800],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.home, color: Colors.white, size: 32),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'InmoBol',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Tu hogar en La Paz',
                    style: TextStyle(
                      color: Colors.blue.shade100,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.filter_list, color: Colors.white),
              onPressed: () {
                // Abrir filtros
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Publicar propiedad
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: Text('Publicar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapControls() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          IconButton(
            icon: Icon(Icons.map),
            color: !_isSatelliteView ? Colors.blue : Colors.grey,
            onPressed: () {
              setState(() {
                _isSatelliteView = false;
              });
            },
            tooltip: 'Mapa',
          ),
          Divider(height: 1),
          IconButton(
            icon: Icon(Icons.satellite_alt),
            color: _isSatelliteView ? Colors.blue : Colors.grey,
            onPressed: () {
              setState(() {
                _isSatelliteView = true;
              });
            },
            tooltip: 'Satélite',
          ),
          Divider(height: 1),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Obtener el zoom actual y sumar 1
              final currentZoom = _mapController.camera.zoom;
              _mapController.move(
                _mapController.camera.center,
                currentZoom + 1,
              );
            },
            tooltip: 'Acercar',
          ),
          Divider(height: 1),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              // Obtener el zoom actual y restar 1
              final currentZoom = _mapController.camera.zoom;
              _mapController.move(
                _mapController.camera.center,
                currentZoom - 1,
              );
            },
            tooltip: 'Alejar',
          ),
          Divider(height: 1),
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              // Volver al centro de La Paz
              _mapController.move(
                LatLng(-16.5000, -68.1193),
                13.0,
              );
            },
            tooltip: 'Centrar',
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Leyenda',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on, color: Colors.orange, size: 16),
              SizedBox(width: 4),
              Text('En Venta', style: TextStyle(fontSize: 11)),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on, color: Colors.green, size: 16),
              SizedBox(width: 4),
              Text('En Alquiler', style: TextStyle(fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyPanel(Property property) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Contenido
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        property.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _selectedProperty = null;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  property.description,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    _buildInfoChip(
                        Icons.bed, '${property.bedrooms} habs'),
                    SizedBox(width: 8),
                    _buildInfoChip(
                        Icons.bathroom, '${property.bathrooms} baños'),
                    SizedBox(width: 8),
                    _buildInfoChip(Icons.square_foot, property.area),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PropertyDetailScreen(
                          property: property,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Ver opciones de visualización',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.blue),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
