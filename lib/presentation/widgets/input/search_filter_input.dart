import 'package:flutter/material.dart';
import 'package:real_estate_app/presentation/widgets/dropdown/category_filter_dropdown.dart';
import 'package:real_estate_app/shared/constants/categories_propery.dart';

class SearchFilterInput extends StatefulWidget {
  final Function(String)? onSearchChanged;
  final void Function()? showFilterDialog;
  final Function(Map<String, String>)? onFiltersChanged;

  const SearchFilterInput({
    super.key,
    this.onSearchChanged,
    this.showFilterDialog,
    this.onFiltersChanged,
  });

  @override
  State<SearchFilterInput> createState() => _SearchFilterInputState();
}

class _SearchFilterInputState extends State<SearchFilterInput> {
  final TextEditingController _searchController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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

                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark ? Colors.black : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: widget.showFilterDialog,
                      icon: const Icon(Icons.tune),
                      color: Colors.deepOrange,
                      iconSize: isMobile ? 24 : 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Filtros de categorías
              CategoryFilterDropdown(
                categories: categoriesProperty,
                isMobile: isMobile,
                onFiltersChanged: widget.onFiltersChanged,
              ),
            ],
          ),
        );
      },
    );
  }
}
