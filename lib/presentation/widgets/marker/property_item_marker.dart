import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final formatter = NumberFormat(
      '#,##0',
      'en_US',
    ); // Removí decimales para ahorrar espacio

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

    return SizedBox(
      width: 80,
      height: 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Precio (si existe)
          if (property.price != null)
            Flexible(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                constraints: const BoxConstraints(maxWidth: 75, maxHeight: 28),
                padding: EdgeInsets.symmetric(
                  horizontal: isSelected ? 6 : 5,
                  vertical: isSelected ? 3 : 2,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFF38118)
                      : isDarkMode
                      ? const Color(0xFF2C2C2C)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFF38118),
                    width: isSelected ? 1.5 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDarkMode ? 0.5 : 0.2,
                      ),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${formatter.format(property.price!)} Bs',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFFF38118),
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
            ),

          // Espaciado mínimo
          if (property.price != null) const SizedBox(height: 2),

          // Ícono
          Flexible(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                iconData,
                color: iconColor,
                size: isSelected ? 36 : 30,
                shadows: const [
                  Shadow(
                    color: Colors.black38,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
