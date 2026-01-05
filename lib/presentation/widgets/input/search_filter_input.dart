import 'package:flutter/material.dart';

class SearchFilterInput extends StatelessWidget {
  final TextEditingController? searchController;
  final VoidCallback? onSearchTap;
  final VoidCallback? onFilterTap;

  const SearchFilterInput({
    super.key,
    this.searchController,
    this.onSearchTap,
    this.onFilterTap,
  });

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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                      onPressed: onSearchTap,
                      icon: const Icon(Icons.search),
                      color: Colors.deepOrange,
                      iconSize: isMobile ? 24 : 28,
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Campo de búsqueda
                  Expanded(
                    child: GestureDetector(
                      onTap: onSearchTap,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 20,
                          vertical: isMobile ? 14 : 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          'Busca por zona',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: isMobile ? 14 : 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Botón de filtros
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                      onPressed: onFilterTap,
                      icon: const Icon(Icons.tune),
                      color: Colors.deepOrange,
                      iconSize: isMobile ? 24 : 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Filtros de categorías (Casas, Departamentos, Locales)
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
        children: [
          _buildCategoryChip(
            icon: Icons.home,
            label: 'Casas',
            isMobile: isMobile,
          ),
          const SizedBox(width: 8),
          _buildCategoryChip(
            icon: Icons.apartment,
            label: 'Departamentos',
            isMobile: isMobile,
          ),
          const SizedBox(width: 8),
          _buildCategoryChip(
            icon: Icons.store,
            label: 'Locales',
            isMobile: isMobile,
          ),
          const SizedBox(width: 8),
          _buildCategoryChip(
            icon: Icons.business,
            label: 'Oficinas',
            isMobile: isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip({
    required IconData icon,
    required String label,
    required bool isMobile,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 16,
        vertical: isMobile ? 8 : 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
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
          Icon(icon, color: Colors.deepOrange, size: isMobile ? 18 : 20),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: isMobile ? 13 : 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.keyboard_arrow_down,
            size: isMobile ? 16 : 18,
            color: Colors.grey[600],
          ),
        ],
      ),
    );
  }
}
