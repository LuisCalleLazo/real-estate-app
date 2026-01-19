import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:real_estate_app/domain/entities/property_marker.dart';
import 'package:real_estate_app/presentation/widgets/button/action_button.dart';

class PropertyPanel extends StatelessWidget {
  final PropertyMarker property;
  const PropertyPanel({super.key, required this.property});
  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              height: 120,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: Image.network(
                'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.home,
                      size: 48,
                      color: Colors.grey.shade400,
                    ),
                  );
                },
              ),
            ),
          ),

          // Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        property.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    if (property.price != null)
                      Text(
                        '${formatter.format(property.price!)} BS',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: const Color(0xFFF38118),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.bed, size: 16),
                    const SizedBox(width: 4),
                    const Text('3'),
                    const SizedBox(width: 16),
                    const Icon(Icons.bathroom, size: 16),
                    const SizedBox(width: 4),
                    const Text('2'),
                    const SizedBox(width: 16),
                    const Icon(Icons.square_foot, size: 16),
                    const SizedBox(width: 4),
                    const Text('180m²'),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: ActionButton(
                    text: "Ver detalles",
                    width: MediaQuery.of(context).size.width * 0.8,
                    onPressed: () {
                      context.go('/property');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
