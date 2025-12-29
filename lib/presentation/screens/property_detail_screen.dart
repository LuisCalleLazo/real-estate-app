// lib/screens/property_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:real_estate_app/infraestructure/model/property.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';

enum ViewMode { none, images, tour360, streetView, satellite }

class PropertyDetailScreen extends StatefulWidget {
  final Property property;

  const PropertyDetailScreen({super.key, required this.property});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  ViewMode _currentView = ViewMode.none;
  int _currentImageIndex = 0;
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentView != ViewMode.none) {
      return _buildFullScreenViewer();
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar con imagen
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.property.images.first,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        widget.property.price,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Contenido
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    widget.property.title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.property.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 24),

                  // Características
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildFeature(
                        Icons.bed,
                        widget.property.bedrooms.toString(),
                        'Habitaciones',
                      ),
                      _buildFeature(
                        Icons.bathroom,
                        widget.property.bathrooms.toString(),
                        'Baños',
                      ),
                      _buildFeature(
                        Icons.square_foot,
                        widget.property.area,
                        'Área',
                      ),
                    ],
                  ),
                  SizedBox(height: 32),

                  // Opciones de visualización
                  Text(
                    'Opciones de Visualización',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),

                  _buildViewOption(
                    icon: Icons.photo_library,
                    title: 'Galería de Fotos',
                    subtitle: '${widget.property.images.length} fotos',
                    gradient: [Colors.purple.shade500, Colors.purple.shade700],
                    onTap: () {
                      setState(() {
                        _currentView = ViewMode.images;
                        _currentImageIndex = 0;
                      });
                    },
                  ),
                  SizedBox(height: 12),

                  _buildViewOption(
                    icon: Icons.threesixty,
                    title: 'Tour Virtual 360°',
                    subtitle: 'Recorrido inmersivo',
                    gradient: [Colors.green.shade500, Colors.green.shade700],
                    onTap: () {
                      setState(() {
                        _currentView = ViewMode.tour360;
                      });
                    },
                  ),
                  SizedBox(height: 12),

                  _buildViewOption(
                    icon: Icons.streetview,
                    title: 'Vista de Calle',
                    subtitle: 'Google Street View',
                    gradient: [Colors.blue.shade500, Colors.blue.shade700],
                    onTap: () {
                      setState(() {
                        _currentView = ViewMode.streetView;
                      });
                    },
                  ),
                  SizedBox(height: 12),

                  _buildViewOption(
                    icon: Icons.satellite_alt,
                    title: 'Vista Satélite',
                    subtitle: 'Google Maps 3D',
                    gradient: [Colors.orange.shade500, Colors.orange.shade700],
                    onTap: () {
                      setState(() {
                        _currentView = ViewMode.satellite;
                      });
                    },
                  ),
                  SizedBox(height: 32),

                  // Botones de acción
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Contactar
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Contactar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Agendar visita
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: Colors.blue, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Agendar Visita',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blue, size: 32),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildViewOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradient.first.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFullScreenViewer() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Contenido según el modo de vista
          if (_currentView == ViewMode.images) _buildImageGallery(),
          if (_currentView == ViewMode.tour360) _buildTour360(),
          if (_currentView == ViewMode.streetView) _buildStreetView(),
          if (_currentView == ViewMode.satellite) _buildSatelliteView(),

          // Botón de cerrar
          SafeArea(
            child: Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 32),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  padding: EdgeInsets.all(12),
                ),
                onPressed: () {
                  setState(() {
                    _currentView = ViewMode.none;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGallery() {
    return Column(
      children: [
        Expanded(
          child: PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(
                  widget.property.images[index],
                ),
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            itemCount: widget.property.images.length,
            loadingBuilder: (context, event) => Center(
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded /
                        event.expectedTotalBytes!,
              ),
            ),
            backgroundDecoration: BoxDecoration(color: Colors.black),
            pageController: PageController(initialPage: _currentImageIndex),
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
          ),
        ),
        // Indicador y miniaturas
        SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  '${_currentImageIndex + 1} / ${widget.property.images.length}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      widget.property.images.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentImageIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: index == _currentImageIndex
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: CachedNetworkImage(
                              imageUrl: widget.property.images[index],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTour360() {
    _webViewController.loadRequest(
      Uri.parse(widget.property.tour360Url),
    );
    return Column(
      children: [
        Expanded(
          child: WebViewWidget(controller: _webViewController),
        ),
        SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            color: Colors.black.withOpacity(0.7),
            child: Column(
              children: [
                Text(
                  widget.property.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Usa el mouse o touch para navegar • Compatible con VR',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStreetView() {
    final lat = widget.property.location.latitude;
    final lng = widget.property.location.longitude;
    
    // IMPORTANTE: Reemplaza YOUR_GOOGLE_API_KEY con tu API key real
    final streetViewUrl =
        'https://www.google.com/maps/embed/v1/streetview?key=YOUR_GOOGLE_API_KEY&location=$lat,$lng&heading=210&pitch=10&fov=90';

    _webViewController.loadRequest(Uri.parse(streetViewUrl));

    return Column(
      children: [
        Expanded(
          child: WebViewWidget(controller: _webViewController),
        ),
        SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            color: Colors.black.withOpacity(0.7),
            child: Column(
              children: [
                Text(
                  widget.property.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Vista de Calle - Google Maps Street View',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSatelliteView() {
    final lat = widget.property.location.latitude;
    final lng = widget.property.location.longitude;
    
    // IMPORTANTE: Reemplaza YOUR_GOOGLE_API_KEY con tu API key real
    final satelliteUrl =
        'https://www.google.com/maps/embed/v1/place?key=YOUR_GOOGLE_API_KEY&q=$lat,$lng&maptype=satellite&zoom=19';

    _webViewController.loadRequest(Uri.parse(satelliteUrl));

    return Column(
      children: [
        Expanded(
          child: WebViewWidget(controller: _webViewController),
        ),
        SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            color: Colors.black.withOpacity(0.7),
            child: Column(
              children: [
                Text(
                  widget.property.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Vista Satélite - Google Maps 3D',
                  style: TextStyle(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}