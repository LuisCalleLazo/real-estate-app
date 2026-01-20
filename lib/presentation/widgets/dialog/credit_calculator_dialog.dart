import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_estate_app/presentation/widgets/button/action_button.dart';
import 'package:real_estate_app/presentation/widgets/input/custom_input.dart';

class CreditCalculatorDialog extends StatefulWidget {
  const CreditCalculatorDialog({Key? key}) : super(key: key);

  @override
  State<CreditCalculatorDialog> createState() => _CreditCalculatorDialogState();
}

class _CreditCalculatorDialogState extends State<CreditCalculatorDialog> {
  final _formKey = GlobalKey<FormState>();
  final _montoController = TextEditingController();
  final _ingresoController = TextEditingController();
  final _inmuebleController = TextEditingController();
  final _deudasController = TextEditingController();
  final _precioCompraController = TextEditingController();
  final _aporteInicialController = TextEditingController();

  String _estadoCivil = '';
  int _plazoMeses = 12;
  bool _viviendaAlquiler = false;

  @override
  void dispose() {
    _montoController.dispose();
    _ingresoController.dispose();
    _inmuebleController.dispose();
    _deudasController.dispose();
    _precioCompraController.dispose();
    _aporteInicialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'CALCULADORA DE CRÉDITOS',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInput(
                        label: '¿Qué monto requiere prestarse?',
                        controller: _montoController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es requerido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      CustomInput(
                        label: '¿Cuál es su ingreso líquido mensual?',
                        controller: _ingresoController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: 16),

                      CustomInput(
                        label: '¿Qué inmueble va a adquirir?',
                        controller: _inmuebleController,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 16),

                      // Estado Civil Dropdown
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: '¿Su estado civil es?',
                          border: OutlineInputBorder(),
                        ),
                        value: _estadoCivil.isEmpty ? null : _estadoCivil,
                        items: const [
                          DropdownMenuItem(
                            value: 'Soltero',
                            child: Text('Soltero'),
                          ),
                          DropdownMenuItem(
                            value: 'Casado',
                            child: Text('Casado'),
                          ),
                          DropdownMenuItem(
                            value: 'Divorciado',
                            child: Text('Divorciado'),
                          ),
                          DropdownMenuItem(
                            value: 'Viudo',
                            child: Text('Viudo'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _estadoCivil = value ?? '';
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Plazo en meses y años
                      Row(
                        children: [
                          Expanded(
                            child: CustomInput(
                              label: 'Plazo en meses',
                              controller: TextEditingController(
                                text: _plazoMeses.toString(),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _plazoMeses = int.tryParse(value) ?? 12;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomInput(
                              label: 'Plazo en años',
                              controller: TextEditingController(
                                text: (_plazoMeses / 12).toStringAsFixed(1),
                              ),
                              enabled: false,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      CustomInput(
                        label:
                            '¿Tiene deudas? Indique el monto mensual que paga',
                        controller: _deudasController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: 16),

                      CustomInput(
                        label: '¿Cuál es el precio de compra del inmueble?',
                        controller: _precioCompraController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Vive en alquiler
                      CheckboxListTile(
                        title: const Text('¿Vide en alquiler?'),
                        value: _viviendaAlquiler,
                        onChanged: (value) {
                          setState(() {
                            _viviendaAlquiler = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: 16),

                      CustomInput(
                        label: '¿Cuál es el monto que tiene de aporte inicial?',
                        controller: _aporteInicialController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: ActionButton(
                text: 'CALCULAR',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop({
                      'monto': _montoController.text,
                      'ingreso': _ingresoController.text,
                      'inmueble': _inmuebleController.text,
                      'estadoCivil': _estadoCivil,
                      'plazoMeses': _plazoMeses,
                      'deudas': _deudasController.text,
                      'precioCompra': _precioCompraController.text,
                      'viviendaAlquiler': _viviendaAlquiler,
                      'aporteInicial': _aporteInicialController.text,
                    });
                  }
                },
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
