import 'package:flutter/material.dart';
import 'package:real_estate_app/domain/entities/property_marker.dart';

class PropertyItemMarker extends StatelessWidget {
  final PropertyMarker property;
  final bool isDarkMode;
  final PropertyMarker selectedProperty;

  const PropertyItemMarker({
    super.key,
    required this.property,
    required this.isDarkMode,
    required this.selectedProperty,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedProperty.id == property.id;

    final Map<MarkerType, Map<String, dynamic>> markerIcons = {
      MarkerType.home: {'icon': Icons.house, 'color': Colors.amber},
      MarkerType.departament: {
        'icon': Icons.apartment,
        'color': Colors.blueAccent,
      },
      MarkerType.terrain: {'icon': Icons.terrain, 'color': Colors.green},
      MarkerType.office: {'icon': Icons.business, 'color': Colors.purple},
      MarkerType.bank: {'icon': Icons.account_balance, 'color': Colors.indigo},
      MarkerType.store: {'icon': Icons.store, 'color': Colors.orange},
    };

    final iconData = markerIcons[property.type]!['icon'] as IconData;
    final iconColor = markerIcons[property.type]!['color'] as Color;

    return AnimatedScale(
      scale: isSelected ? 1.4 : 1.0,
      duration: const Duration(milliseconds: 150),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.orange.withValues(alpha: 0.6),
                    blurRadius: 18,
                    spreadRadius: 6,
                  ),
                  BoxShadow(
                    color: Colors.orange.withValues(alpha: 0.9),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Center(child: Icon(iconData, color: iconColor, size: 23)),
      ),
    );
  }
}
