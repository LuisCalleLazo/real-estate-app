import 'package:flutter/material.dart';
import 'package:real_estate_app/presentation/widgets/card/property_option_card.dart';

class InitHomeScreen extends StatelessWidget {
  const InitHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 1200;

        if (isDesktop) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 2.5, 
            children: [
              PropertyOptionCard(),
              PropertyOptionCard(),
              PropertyOptionCard(),
              PropertyOptionCard(),
            ],
          );
        }

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth < 600 ? constraints.maxWidth : 700,
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
        );
      },
    );
  }
}
