import 'package:flutter/material.dart';
import 'package:real_estate_app/presentation/widgets/card/property_option_short_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Determinar el número de columnas y ancho máximo por tarjeta
        int crossAxisCount = 1;
        double maxCardWidth = 500; // Ancho máximo para cada tarjeta

        if (width > 1200) {
          // Desktop grande: 3 columnas
          crossAxisCount = 3;
          maxCardWidth = 380;
        } else if (width > 800) {
          // Desktop/Tablet: 2 columnas
          crossAxisCount = 2;
          maxCardWidth = 400;
        } else if (width > 600) {
          // Tablet pequeño: 2 columnas
          crossAxisCount = 2;
          maxCardWidth = 350;
        } else {
          // Móvil: 1 columna
          crossAxisCount = 1;
          maxCardWidth = width;
        }

        // Crear lista de widgets mezclados
        final items = _buildMixedItems();

        return Column(
          children: [
            Expanded(
              child: crossAxisCount > 1
                  ? _buildGridView(crossAxisCount, maxCardWidth, items)
                  : _buildListView(width, items),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildMixedItems() {
    return [
      PropertyOptionShortCard(
        favorite: true,
        title: 'Casa san pedro',
        description: 'Casa ubicando en el centro de La Paz',
        price: 3000,
        imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800',
        location: '',
        bedrooms: 1,
        bathrooms: 2,
        parkingLots: 3,
        kitchens: 1,
      ),
    ];
  }

  Widget _buildGridView(
    int crossAxisCount,
    double maxCardWidth,
    List<Widget> items,
  ) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: (maxCardWidth * crossAxisCount) + (crossAxisCount * 16),
        ),
        child: GridView.builder(
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.85,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) => items[index],
        ),
      ),
    );
  }

  // ListView para móviles
  Widget _buildListView(double width, List<Widget> items) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width < 600 ? width : 500),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8),
          itemCount: items.length,
          itemBuilder: (context, index) => items[index],
        ),
      ),
    );
  }
}
