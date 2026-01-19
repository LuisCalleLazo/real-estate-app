import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PropertyOptionShortCard extends StatelessWidget {
  final bool favorite;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String location;
  final int bedrooms;
  final int bathrooms;
  final int parkingLots;
  final int kitchens;

  const PropertyOptionShortCard({
    super.key,
    required this.favorite,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.location,
    required this.bedrooms,
    required this.bathrooms,
    required this.parkingLots,
    required this.kitchens,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determinar si estamos en modo compacto
        final isCompact = constraints.maxWidth < 380;

        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: isCompact ? 8 : 12,
            vertical: 6,
          ),
          child: InkWell(
            onTap: () {
              context.push('/property');
            },
            borderRadius: BorderRadius.circular(16),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // Imagen con botón favorito
                  _buildImageSection(context, isCompact),

                  // Título centrado
                  SizedBox(
                    height: 40,
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: isCompact ? 16 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // Contenido: características, descripción y precio
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Características en fila
                      _buildFeatures(isCompact),

                      SizedBox(height: 10),

                      // Descripción
                      Center(
                        child: Text(
                          description,
                          style: TextStyle(
                            fontSize: isCompact ? 11 : 12,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: 10),

                      // Precio
                      Center(
                        child: Text(
                          '${formatter.format(price)} BS',
                          style: TextStyle(
                            fontSize: isCompact ? 16 : 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF7043),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSection(BuildContext context, bool isCompact) {
    return Stack(
      children: [
        // Imagen principal
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: AspectRatio(
            aspectRatio: 1.4,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[200],
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                      color: Color(0xFFFF7043),
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return SizedBox(child: Icon(Icons.broken_image, size: 32));
              },
            ),
          ),
        ),

        // Botón de favoritos (corazón)
        Positioned(
          top: 6,
          right: 6,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: IconButton(
              icon: Icon(
                favorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                size: isCompact ? 18 : 20,
              ),
              onPressed: () {
                // Toggle favorito
              },
              padding: EdgeInsets.all(6),
              constraints: BoxConstraints(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatures(bool isCompact) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFeatureItem(
            icon: Icons.meeting_room_outlined,
            label: bedrooms.toString(),
            isCompact: isCompact,
          ),
          _buildFeatureItem(
            icon: Icons.bathtub_outlined,
            label: bathrooms.toString(),
            isCompact: isCompact,
          ),
          _buildFeatureItem(
            icon: Icons.bedroom_parent_outlined,
            label: kitchens.toString(),
            isCompact: isCompact,
          ),
          _buildFeatureItem(
            icon: Icons.directions_car_outlined,
            label: parkingLots.toString(),
            isCompact: isCompact,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String label,
    required bool isCompact,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: isCompact ? 14 : 16, color: Colors.grey[500]),
        SizedBox(width: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: isCompact ? 11 : 12,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
