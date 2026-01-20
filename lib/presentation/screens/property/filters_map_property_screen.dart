import 'package:flutter/material.dart';
import 'package:real_estate_app/presentation/screens/property/select_zone_on_map_screen.dart';
import 'package:real_estate_app/presentation/widgets/button/action_button.dart';
import 'package:real_estate_app/presentation/widgets/button/action_outlined_button.dart';
import 'package:real_estate_app/presentation/widgets/slider/custom_slider.dart';

class FiltersMapPropertyScreen extends StatefulWidget {
  final Function(Map<String, dynamic>)? onFiltersChanged;

  const FiltersMapPropertyScreen({super.key, this.onFiltersChanged});

  @override
  State<FiltersMapPropertyScreen> createState() => _FiltersMapPropertyState();
}

class _FiltersMapPropertyState extends State<FiltersMapPropertyScreen> {
  List<String> selectedZones = [];
  bool showAllZones = true;

  final List<Map<String, dynamic>> banks = [
    {'name': 'BNB', 'logo': 'images/banks/banco_bnb_logo.png'},
    {
      'name': 'MERCANTIL SANTA CRUZ',
      'logo': 'images/banks/banco_mercantil-santa-cruz_logo.png',
    },
    {'name': 'BANCO SOL', 'logo': 'images/banks/banco_sol_logo.png'},
    {'name': 'BANCO UNION', 'logo': 'images/banks/banco_union_logo3.png'},
  ];
  List<String> selectedBanks = [];

  RangeValues priceRange = const RangeValues(0, 1000000);
  final double minPrice = 0;
  final double maxPrice = 2000000;

  // Lista de zonas de ejemplo (deberías cargarlas de tu modelo)
  List<String> availableZones = [
    'Sopocachi',
    'Calacoto',
    'San Miguel',
    'Obrajes',
    'Miraflores',
  ];

  void _notifyFiltersChanged() {
    widget.onFiltersChanged?.call({
      'zones': showAllZones ? [] : selectedZones,
      'banks': selectedBanks,
      'priceRange': {'min': priceRange.start, 'max': priceRange.end},
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Zonas', Icons.location_on),
          const SizedBox(height: 12),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Mostrar todas las zonas'),
            value: showAllZones,
            onChanged: (value) {
              setState(() {
                showAllZones = value;
                if (value) selectedZones.clear();
              });
              _notifyFiltersChanged();
            },
          ),

          if (!showAllZones) ...[
            const SizedBox(height: 8),

            if (selectedZones.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: selectedZones.map((zone) {
                  return Chip(
                    label: Text(zone),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      setState(() {
                        selectedZones.remove(zone);
                      });
                      _notifyFiltersChanged();
                    },
                  );
                }).toList(),
              ),

            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectZoneOnMapScreen(),
                  ),
                );

                if (result != null && result is String) {
                  setState(() {
                    if (!selectedZones.contains(result)) {
                      selectedZones.add(result);
                    }
                  });
                  _notifyFiltersChanged();
                }
              },
              icon: const Icon(Icons.add_location),
              label: const Text('Agregar zona personalizada'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 44),
              ),
            ),

            const SizedBox(height: 12),

            if (availableZones.isNotEmpty) ...[
              Text('Zonas disponibles:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: availableZones.map((zone) {
                  final isSelected = selectedZones.contains(zone);
                  return FilterChip(
                    label: Text(zone),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedZones.add(zone);
                        } else {
                          selectedZones.remove(zone);
                        }
                      });
                      _notifyFiltersChanged();
                    },
                  );
                }).toList(),
              ),
            ],
          ],

          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 24),

          _buildSectionTitle('Bancos', Icons.account_balance),
          const SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: banks.length,
            itemBuilder: (context, index) {
              final bank = banks[index];
              final isSelected = selectedBanks.contains(bank['name']);

              return InkWell(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedBanks.remove(bank['name']);
                    } else {
                      selectedBanks.add(bank['name']);
                    }
                  });
                  _notifyFiltersChanged();
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.dividerColor,
                      width: isSelected ? 2.5 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: isSelected
                        ? theme.colorScheme.primary.withValues(alpha: 0.1)
                        : theme.colorScheme.surface,
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            bank['logo'],
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.account_balance,
                                    size: 32,
                                    color: theme.colorScheme.primary,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    bank['name'],
                                    style: theme.textTheme.bodySmall,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      if (isSelected)
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              size: 16,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 24),

          const SizedBox(height: 16),
          _buildSectionTitle('Rango de Precios', Icons.attach_money),
          CustomSlider(valueRange: priceRange, onValueChange: (values) {}),

          const SizedBox(height: 32),

          // Botones de acción
          Row(
            children: [
              Expanded(
                child: ActionOutlinedButton(
                  onPressed: () {
                    setState(() {
                      selectedZones.clear();
                      showAllZones = true;
                      selectedBanks.clear();
                      priceRange = RangeValues(minPrice, maxPrice);
                    });
                    _notifyFiltersChanged();
                  },
                  text: 'Limpiar filtros',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ActionButton(
                  text: 'Aplicar',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
