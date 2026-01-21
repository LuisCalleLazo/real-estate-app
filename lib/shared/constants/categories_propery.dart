import 'package:flutter/material.dart';
import 'package:real_estate_app/presentation/widgets/dropdown/category_filter_dropdown.dart';
import 'package:real_estate_app/shared/utils/select_option.dart';

final List<CategoryFilter> categoriesProperty = [
  CategoryFilter(
    id: 'pago',
    icon: Icons.payment,
    label: 'Pago',
    options: [
      SelectOption(label: 'Todas', value: 'all'),
      SelectOption(label: 'En venta', value: 'sale'),
      SelectOption(label: 'En alquiler', value: 'rent'),
      SelectOption(label: 'En anticrético', value: 'anticrético'),
    ],
  ),
  CategoryFilter(
    id: 'propiedad',
    icon: Icons.apartment,
    label: 'Propiedad',
    options: [
      SelectOption(label: 'Todos', value: 'all'),
      SelectOption(label: 'Casa', value: 'house'),
      SelectOption(label: 'Departamento', value: 'apartment'),
      SelectOption(label: 'Terreno', value: 'land'),
    ],
  ),
  CategoryFilter(
    id: 'banos',
    icon: Icons.store,
    label: 'Baños',
    options: [
      SelectOption(label: 'Todos', value: 'all'),
      SelectOption(label: '1 Baño', value: '1'),
      SelectOption(label: '2 Baños', value: '2'),
      SelectOption(label: '3 Baños', value: '3'),
      SelectOption(label: '+4 Baños', value: '+4'),
    ],
  ),
  CategoryFilter(
    id: 'habitaciones',
    icon: Icons.business,
    label: 'Habitaciones',
    options: [
      SelectOption(label: 'Todos', value: 'all'),
      SelectOption(label: '1 Habitación', value: '1'),
      SelectOption(label: '2 Habitaciones', value: '2'),
      SelectOption(label: '3 Habitaciones', value: '3'),
      SelectOption(label: '+4 Habitaciones', value: '+4'),
    ],
  ),
  CategoryFilter(
    id: 'cocinas',
    icon: Icons.business,
    label: 'Cocinas',
    options: [
      SelectOption(label: 'Todos', value: 'all'),
      SelectOption(label: '1 Cocina', value: '1'),
      SelectOption(label: '2 Cocinas', value: '2'),
      SelectOption(label: '3 Cocinas', value: '3'),
      SelectOption(label: '+4 Cocinas', value: '+4'),
    ],
  ),
];
