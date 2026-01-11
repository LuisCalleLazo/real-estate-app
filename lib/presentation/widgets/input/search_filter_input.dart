import 'package:flutter/material.dart';

// Modelo para las categorías
class CategoryFilter {
  final String id;
  final IconData icon;
  final String label;
  final List<String> options;

  CategoryFilter({
    required this.id,
    required this.icon,
    required this.label,
    required this.options,
  });
}

// Widget principal con estado
class SearchFilterInput extends StatefulWidget {
  final Function(String)? onSearchChanged;
  final Function(Map<String, String>)? onFiltersChanged;

  const SearchFilterInput({
    super.key,
    this.onSearchChanged,
    this.onFiltersChanged,
  });

  @override
  State<SearchFilterInput> createState() => _SearchFilterInputState();
}

class _SearchFilterInputState extends State<SearchFilterInput> {
  final TextEditingController _searchController = TextEditingController();
  final Map<String, String> _selectedFilters = {};

  // Define las categorías con sus opciones
  final List<CategoryFilter> _categories = [
    CategoryFilter(
      id: 'casas',
      icon: Icons.home,
      label: 'Casas',
      options: ['Todas', 'En venta', 'En alquiler', 'Amobladas', 'Sin amoblar'],
    ),
    CategoryFilter(
      id: 'departamentos',
      icon: Icons.apartment,
      label: 'Departamentos',
      options: [
        'Todos',
        '1 dormitorio',
        '2 dormitorios',
        '3 dormitorios',
        '4+ dormitorios',
      ],
    ),
    CategoryFilter(
      id: 'locales',
      icon: Icons.store,
      label: 'Locales',
      options: [
        'Todos',
        'Comerciales',
        'Industriales',
        'Restaurantes',
        'Oficinas',
      ],
    ),
    CategoryFilter(
      id: 'oficinas',
      icon: Icons.business,
      label: 'Oficinas',
      options: [
        'Todas',
        'Individuales',
        'Compartidas',
        'Coworking',
        'Edificio completo',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (widget.onSearchChanged != null) {
      widget.onSearchChanged!(_searchController.text);
    }
  }

  void _onFilterChanged(String categoryId, String value) {
    setState(() {
      _selectedFilters[categoryId] = value;
    });

    if (widget.onFiltersChanged != null) {
      widget.onFiltersChanged!(_selectedFilters);
    }

    // Imprime en consola para debugging
    // print('Filtros actualizados: $_selectedFilters');
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtros avanzados'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Aquí puedes agregar filtros adicionales como:'),
              const SizedBox(height: 8),
              const Text('• Rango de precios'),
              const Text('• Metros cuadrados'),
              const Text('• Número de baños'),
              const Text('• Amenidades'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Aquí aplicarías los filtros
            },
            child: const Text('Aplicar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 20,
            vertical: isMobile ? 12 : 16,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  // Campo de búsqueda
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Busca por zona',
                          hintStyle: TextStyle(fontSize: isMobile ? 14 : 16),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.deepOrange,
                            size: isMobile ? 24 : 28,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 16 : 20,
                            vertical: isMobile ? 14 : 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Botón de filtros
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: _showFilterDialog,
                      icon: const Icon(Icons.tune),
                      color: Colors.deepOrange,
                      iconSize: isMobile ? 24 : 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Filtros de categorías
              _buildCategoryFilters(isMobile),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryFilters(bool isMobile) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _buildCategoryChip(category: category, isMobile: isMobile),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryChip({
    required CategoryFilter category,
    required bool isMobile,
  }) {
    final isSelected = _selectedFilters.containsKey(category.id);

    return PopupMenuButton<String>(
      onSelected: (value) => _onFilterChanged(category.id, value),
      itemBuilder: (context) => category.options.map((option) {
        return PopupMenuItem<String>(
          value: option,
          child: Row(
            children: [
              if (_selectedFilters[category.id] == option)
                const Icon(Icons.check, size: 18, color: Colors.deepOrange),
              if (_selectedFilters[category.id] == option)
                const SizedBox(width: 8),
              Text(option),
            ],
          ),
        );
      }).toList(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 16,
          vertical: isMobile ? 8 : 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(category.icon, size: isMobile ? 18 : 20),
            const SizedBox(width: 6),
            Text(
              isSelected && _selectedFilters[category.id] != null
                  ? _selectedFilters[category.id]!
                  : category.label,
              style: TextStyle(
                fontSize: isMobile ? 13 : 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down, size: isMobile ? 16 : 18),
          ],
        ),
      ),
    );
  }
}

// Ejemplo de uso
class ExampleUsage extends StatelessWidget {
  const ExampleUsage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Búsqueda de Propiedades')),
      body: Column(
        children: [
          SearchFilterInput(
            onSearchChanged: (searchText) {
              // print('Búsqueda: $searchText');
            },
            onFiltersChanged: (filters) {
              // print('Filtros aplicados: $filters');
            },
          ),
          const Expanded(
            child: Center(child: Text('Aquí irían los resultados de búsqueda')),
          ),
        ],
      ),
    );
  }
}
