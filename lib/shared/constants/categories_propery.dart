import 'package:flutter/material.dart';
import 'package:real_estate_app/presentation/widgets/dropdown/category_filter_dropdown.dart';

final List<CategoryFilter> categoriesProperty = [
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
