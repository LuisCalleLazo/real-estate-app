import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_estate_app/presentation/widgets/button/action_button.dart';
import 'package:real_estate_app/presentation/widgets/button/action_outlined_button.dart';
import 'package:real_estate_app/presentation/widgets/carousel/images_carousel.dart';

class DetailPropertyPage extends StatelessWidget {
  static String name = 'detail_property_page';
  const DetailPropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    // Imágenes de ejemplo
    final images = [
      'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
      'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800',
      'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
      'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
      'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800',
      'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Carousel
          ImagesCarousel(images: images, height: isTablet ? 400 : 300),

          // Contenido de la propiedad
          Padding(
            padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título y precio
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Property 2',
                            style: TextStyle(
                              fontSize: isTablet ? 28 : 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Bali, Kuta, DV N0007',
                            style: TextStyle(fontSize: isTablet ? 16 : 14),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Precio
                Text(
                  '\$1,000,000',
                  style: TextStyle(
                    fontSize: isTablet ? 32 : 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 24),

                // Características
                Wrap(
                  spacing: isTablet ? 24 : 16,
                  runSpacing: 16,
                  children: [
                    _buildFeature(Icons.bed, '2 Beds', isTablet),
                    _buildFeature(Icons.bathtub, '2 Bath', isTablet),
                    _buildFeature(Icons.square_foot, '18%', isTablet),
                    _buildFeature(Icons.apartment, '5 years rent', isTablet),
                  ],
                ),

                const SizedBox(height: 32),

                // Descripción
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: isTablet ? 22 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
                  style: TextStyle(fontSize: isTablet ? 16 : 14, height: 1.6),
                ),

                const SizedBox(height: 32),

                Row(
                  children: [
                    Expanded(
                      child: ActionOutlinedButton(
                        text: "Edit Detail",
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ActionButton(
                        text: "Photo gallery",
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),

                SizedBox(height: isTablet ? 32 : 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String label, bool isTablet) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: isTablet ? 24 : 20),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: isTablet ? 16 : 14)),
      ],
    );
  }
}
