import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/domain/entities/property_entity.dart';
import 'package:real_estate_app/presentation/provider/property_provider.dart';
import 'package:real_estate_app/presentation/widgets/card/property_option_short_card.dart';
import 'package:real_estate_app/presentation/widgets/input/search_filter_input.dart';

class InitHomeScreen extends StatefulWidget {
  const InitHomeScreen({super.key});

  @override
  State<InitHomeScreen> createState() => _InitHomeScreenState();
}

class _InitHomeScreenState extends State<InitHomeScreen> {
  @override
  void initState() {
    super.initState();

    // Llamada correcta al Provider
    Future.microtask(() {
      context.read<PropertyProvider>().loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PropertyProvider>();

    // LOADING
    if (provider.isLoadingData) {
      return const Center(child: CircularProgressIndicator());
    }

    // EMPTY STATE
    if (provider.properties.isEmpty) {
      return const Center(child: Text('No hay propiedades disponibles'));
    }

    final items = _buildItemsFromData(provider.properties);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        int crossAxisCount = 1;
        double maxCardWidth = 500;

        if (width > 1200) {
          crossAxisCount = 3;
          maxCardWidth = 380;
        } else if (width > 800) {
          crossAxisCount = 2;
          maxCardWidth = 400;
        } else if (width > 600) {
          crossAxisCount = 2;
          maxCardWidth = 350;
        } else {
          crossAxisCount = 1;
          maxCardWidth = width;
        }

        return Column(
          children: [
            SearchFilterInput(
              onSearchChanged: (value) {
                // luego aquí filtras desde el provider
              },
              onFiltersChanged: (values) {
                // filtros futuros
              },
            ),
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

  // Construye tarjetas desde la data del provider
  List<Widget> _buildItemsFromData(List<PropertyEntity> properties) {
    return properties.map((property) {
      return PropertyOptionShortCard(
        favorite: property.isFavorite,
        title: property.title,
        description: property.description,
        price: property.price,
        parkingLots: property.parkingLots,
        bathrooms: property.bathrooms,
        bedrooms: property.bedrooms,
        kitchens: property.kitchens,
        location: property.ubication,
        imageUrl: property.photos[0],
      );
    }).toList();
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
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // se ajusta por el parent
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
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: items.length,
          itemBuilder: (context, index) => items[index],
        ),
      ),
    );
  }
}
