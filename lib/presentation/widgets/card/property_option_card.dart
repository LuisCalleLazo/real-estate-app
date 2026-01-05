import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_estate_app/presentation/widgets/button/action_button.dart';

class PropertyOptionCard extends StatelessWidget {
  const PropertyOptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final cardHeight = isMobile ? 280.0 : 320.0;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 10 : 20,
            vertical: isMobile ? 5 : 10,
          ),
          height: cardHeight,
          child: Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 10 : 20,
                vertical: isMobile ? 10 : 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Primera fila: Imagen + info principal
                  Flexible(
                    flex: 3,
                    child: _buildFirstPropertyCard(context, isMobile),
                  ),

                  Divider(height: isMobile ? 8 : 12),

                  // Segunda fila: Características
                  Flexible(
                    flex: 1,
                    child: _buildSecondPropertyCard(context, isMobile),
                  ),

                  Divider(height: isMobile ? 8 : 12),

                  // Tercera fila: Precio y botón
                  Flexible(
                    flex: 1,
                    child: _buildThirdPropertyCard(context, isMobile),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFirstPropertyCard(BuildContext context, bool isMobile) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 4,
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800",
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.orange[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.broken_image,
                          size: 50,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            SizedBox(width: isMobile ? 10 : 15),

            Flexible(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Título con posibilidad de overflow
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Propiedad 1",
                      style: TextStyle(
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Descripción
                  Flexible(
                    child: Text(
                      "Hermosa propiedad en zona exclusiva con vista al mar",
                      style: TextStyle(fontSize: isMobile ? 14 : 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Ubicación
                  Flexible(
                    child: Row(
                      children: [
                        Icon(Icons.location_on, size: isMobile ? 16 : 18),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            "Zona Premium, Ciudad",
                            style: TextStyle(fontSize: isMobile ? 14 : 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Metros cuadrados
                  Flexible(
                    child: Row(
                      children: [
                        Icon(Icons.square_foot, size: isMobile ? 16 : 18),
                        SizedBox(width: 4),
                        Text(
                          "150 m²",
                          style: TextStyle(fontSize: isMobile ? 14 : 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            icon: Icon(
              CupertinoIcons.heart,
              color: Colors.red,
              size: isMobile ? 24 : 28,
            ),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ),
      ],
    );
  }

  Widget _buildSecondPropertyCard(BuildContext context, bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildFeatureItem(
          icon: Icons.garage_outlined,
          label: "1",
          isMobile: isMobile,
          tooltip: "Estacionamientos",
        ),
        _buildFeatureItem(
          icon: Icons.bathtub_outlined,
          label: "1",
          isMobile: isMobile,
          tooltip: "Baños",
        ),
        _buildFeatureItem(
          icon: Icons.bed_outlined,
          label: "1",
          isMobile: isMobile,
          tooltip: "Cuartos",
        ),
        // Spacer para empujar el precio a la derecha
        Spacer(),
        // Precio
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "\$ 250,000",
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: isMobile ? 16 : 20,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String label,
    required bool isMobile,
    String? tooltip,
  }) {
    return Flexible(
      child: Tooltip(
        message: tooltip ?? '',
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: isMobile ? 20 : 24, color: Colors.grey[700]),
            SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThirdPropertyCard(BuildContext context, bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: Row(
            children: [
              Icon(Icons.square_foot, size: isMobile ? 16 : 18),
              SizedBox(width: 4),
              Flexible(
                child: Text(
                  "227 Sqft",
                  style: TextStyle(fontSize: isMobile ? 14 : 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

        Spacer(),

        Flexible(
          flex: 1,
          child: ActionButton(
            text: "Ver",
            width: isMobile ? 60 : 80,
            fontSize: isMobile ? 12 : 14,
            onPressed: () {
              context.go("/property/");
            },
          ),
        ),
      ],
    );
  }
}
