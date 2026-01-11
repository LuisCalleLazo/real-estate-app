import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_estate_app/presentation/widgets/carousel/images_carousel.dart';

// RUTA PARA PANTALLA COMPLETA
class ImagesPropertyPage extends StatelessWidget {
  static String name = "images_property_page";
  final List<String> images;

  const ImagesPropertyPage({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Carrusel en pantalla completa
          ImagesCarousel(
            images: images,
            height: double.infinity,
            showThumbnails: true,
          ),

          Positioned(
            top: 40,
            right: 16,
            child: SafeArea(
              child: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.close),
                iconSize: 28,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black.withValues(alpha: 0.5),
                  padding: const EdgeInsets.all(12),
                  shape: const CircleBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
