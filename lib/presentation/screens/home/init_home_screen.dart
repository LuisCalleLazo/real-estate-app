import 'package:flutter/material.dart';
import 'package:real_estate_app/presentation/widgets/card/property_option_card.dart';
import 'package:real_estate_app/presentation/widgets/input/search_filter_input.dart';

class InitHomeScreen extends StatelessWidget {
  const InitHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 1200;

        return Column(
          children: [
            SearchFilterInput(
              onSearchTap: () {
                // Aquí puedes navegar a una pantalla de búsqueda completa
                // o mostrar un diálogo
              },
              onFilterTap: () {
                // Aquí puedes abrir un bottom sheet o navegar a filtros
              },
            ),

            // Lista de propiedades
            Expanded(
              child: isDesktop
                  ? GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 2.5,
                      children: [
                        PropertyOptionCard(),
                        PropertyOptionCard(),
                        PropertyOptionCard(),
                        PropertyOptionCard(),
                      ],
                    )
                  : Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth < 600
                              ? constraints.maxWidth
                              : 700,
                        ),
                        child: ListView(
                          children: [
                            PropertyOptionCard(),
                            PropertyOptionCard(),
                            PropertyOptionCard(),
                            PropertyOptionCard(),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
