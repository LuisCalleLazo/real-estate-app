import 'package:flutter/material.dart';
import 'package:real_estate_app/presentation/services/input_controller_manager.dart';
import 'package:real_estate_app/presentation/widgets/dropdown/search_string_dropdown.dart';
import 'package:real_estate_app/presentation/widgets/input/custom_input.dart';
import 'package:real_estate_app/shared/types/property_types.dart';

class PublicPropertyScreen extends StatefulWidget {
  const PublicPropertyScreen({super.key});

  @override
  State<PublicPropertyScreen> createState() => _PublicPropertyScreenState();
}

class _PublicPropertyScreenState extends State<PublicPropertyScreen> {
  final InputControllerManager _inputManager = InputControllerManager();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomInput(
          label: "Titulo de propiedad",
          controller: _inputManager.getController("title_add_property"),
        ),
        CustomInput(
          label: "Descripcion",
          controller: _inputManager.getController("desc_add_property"),
        ),
        CustomInput(
          label: "Ingresar su nombre o correo",
          controller: _inputManager.getController("email_login"),
        ),
        SearchStringDropdown(
          label: "Categoria",
          options: propertyCategoryGroups,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
