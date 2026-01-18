import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/presentation/provider/property_provider.dart';
import 'package:real_estate_app/presentation/services/input_controller_manager.dart';
import 'package:real_estate_app/presentation/services/value_notifier_manager.dart';
import 'package:real_estate_app/presentation/widgets/button/action_button.dart';
import 'package:real_estate_app/presentation/widgets/dropdown/search_string_dropdown.dart';
import 'package:real_estate_app/presentation/widgets/input/custom_input.dart';
import 'package:real_estate_app/presentation/widgets/input/file_field_input.dart';
import 'package:real_estate_app/shared/types/property_types.dart';

class PublicPropertyScreen extends StatefulWidget {
  const PublicPropertyScreen({super.key});

  @override
  State<PublicPropertyScreen> createState() => _PublicPropertyScreenState();
}

class _PublicPropertyScreenState extends State<PublicPropertyScreen> {
  final InputControllerManager _inputManager = InputControllerManager();
  final valueManagerString = ValueNotifierManager<String?>();
  late PropertyProvider _provider;
  List<File> _images = [];
  void _addProperty() async {
    _provider = context.read<PropertyProvider>();

    await _provider.addProperty(
      _inputManager.getController('title_add_property').text,
      _inputManager.getController('desc_add_property').text,
      _inputManager.getController('ubication_add_property').text,
      double.tryParse(_inputManager.getController('price_add_property').text) ??
          0,
      valueManagerString.getNotifier("property_type_add_property").value ?? "",
      valueManagerString.getNotifier("property_category_add_property").value ??
          "",
      valueManagerString.getNotifier("property_type_pay_add_property").value ??
          "",
      valueManagerString.getNotifier("property_zone_add_property").value ?? "",
      int.tryParse(_inputManager.getController('bedrooms_add_property').text) ??
          0,
      int.tryParse(
            _inputManager.getController('bathrooms_add_property').text,
          ) ??
          0,
      int.tryParse(
            _inputManager.getController('parkingLots_add_property').text,
          ) ??
          0,
      int.tryParse(_inputManager.getController('kitchens_add_property').text) ??
          0,
      _images,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text(
              "Agrega una publiacion",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        CustomInput(
          label: "Titulo de propiedad",
          controller: _inputManager.getController("title_add_property"),
        ),
        CustomInput(
          label: "Descripcion",
          controller: _inputManager.getController("desc_add_property"),
        ),
        CustomInput(
          label: "Ubicacion",
          controller: _inputManager.getController("ubication_add_property"),
        ),
        CustomInput(
          label: "Precio",
          controller: _inputManager.getController("price_add_property"),
          keyboardType: TextInputType.number,
        ),
        SearchStringDropdown(
          label: "Tipo de propiedad",
          options: propertyTypes,
          onChanged: (value) {
            valueManagerString.setNotifierValue(
              "property_type_add_property",
              value,
            );
          },
        ),
        SearchStringDropdown(
          label: "Categoria",
          options: propertyCategoryGroups,
          onChanged: (value) {
            valueManagerString.setNotifierValue(
              "property_category_add_property",
              value,
            );
          },
        ),
        SearchStringDropdown(
          label: "Tipo de pago",
          options: propertyPaymentTypes,
          onChanged: (value) {
            valueManagerString.setNotifierValue(
              "property_type_pay_add_property",
              value,
            );
          },
        ),
        SearchStringDropdown(
          label: "Zona",
          options: propertyAreaZones,
          onChanged: (value) {
            valueManagerString.setNotifierValue(
              "property_zone_add_property",
              value,
            );
          },
        ),
        FileFieldInput(
          label: "Imagenes de propiedad",
          fileType: FileType.image,
          multiple: true,
          onFilesSelected: (value) {
            _images = value;
          },
        ),
        CustomInput(
          label: "Cantidad de baños",
          controller: _inputManager.getController("bathrooms_add_property"),
          keyboardType: TextInputType.number,
        ),
        CustomInput(
          label: "Cantidad de habitaciones",
          controller: _inputManager.getController("bedrooms_add_property"),
          keyboardType: TextInputType.number,
        ),
        CustomInput(
          label: "Cantidad de estacionamientos",
          controller: _inputManager.getController("parkings_add_property"),
          keyboardType: TextInputType.number,
        ),
        CustomInput(
          label: "Cantidad de cocinas",
          controller: _inputManager.getController("kitchens_add_property"),
          keyboardType: TextInputType.number,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: ActionButton(text: "Publicar", onPressed: _addProperty),
        ),
      ],
    );
  }
}
