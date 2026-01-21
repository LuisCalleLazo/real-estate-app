import 'package:flutter/material.dart';
import 'package:real_estate_app/shared/utils/select_option.dart';

class CategoryFilter {
  final String id;
  final IconData icon;
  final String label;
  final List<SelectOption> options;

  CategoryFilter({
    required this.id,
    required this.icon,
    required this.label,
    required this.options,
  });
}

class CategoryFilterDropdown extends StatefulWidget {
  final List<CategoryFilter> categories;
  final bool isMobile;
  final Function(Map<String, String>)? onFiltersChanged;
  const CategoryFilterDropdown({
    super.key,
    required this.categories,
    required this.isMobile,
    this.onFiltersChanged,
  });

  @override
  State<CategoryFilterDropdown> createState() => _CategoryFilterDropdownState();
}

class _CategoryFilterDropdownState extends State<CategoryFilterDropdown> {
  final Map<String, String> _selectedFilters = {};

  void _onFilterChanged(String categoryId, SelectOption value) {
    setState(() {
      _selectedFilters[categoryId] = value.label;
    });

    if (widget.onFiltersChanged != null) {
      widget.onFiltersChanged!(_selectedFilters);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _buildCategoryChip(
              category: category,
              isMobile: widget.isMobile,
            ),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopupMenuButton<SelectOption>(
      onSelected: (value) => _onFilterChanged(category.id, value),
      itemBuilder: (context) => category.options.map((option) {
        final isSelected = _selectedFilters[category.id] == option.value;
        return PopupMenuItem<SelectOption>(
          value: option,
          child: Row(
            children: [
              if (isSelected)
                const Icon(Icons.check, size: 18, color: Colors.deepOrange),
              if (isSelected) const SizedBox(width: 8),
              Text(option.label),
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
          color: isDark ? Colors.black : Colors.white,
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
