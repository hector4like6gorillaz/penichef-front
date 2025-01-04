import 'package:base_app/components/inputText/input_text.dart';
import 'package:base_app/modules/inventary/subModules/addToInventary/models/add_inventary_model.dart';
import 'package:flutter/material.dart';

class AddToInventary extends StatefulWidget {
  const AddToInventary({super.key});

  @override
  State<AddToInventary> createState() => _AddToInventaryState();
}

class _AddToInventaryState extends State<AddToInventary> {
  final _formKey = GlobalKey<FormState>();
  final AddToInventaroForm _formAddToInventary = AddToInventaroForm();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: InputText(
                  topLabelText: "Nombre del producto",
                  handle: (value) => _formAddToInventary.producto = value,
                  hintText: "Nombre del producto",
                  validador: "Ingresa un nombre valido",
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: InputText(
                  topLabelText: "Marca",
                  handle: (value) => _formAddToInventary.brand = value,
                  hintText: "Marca del producto",
                  validador: "Ingresa una marca valida",
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: InputText(
                  topLabelText: "Cantidad de producto",
                  handle: (value) =>
                      _formAddToInventary.quanty = double.parse(value),
                  hintText: "Numero",
                  validador: "Ingresa un numero valido",
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: InputText(
                  topLabelText: "Unidad de medida",
                  handle: (value) => _formAddToInventary.unidadDeMedida = value,
                  hintText: "Litro, kilo, etc...",
                  validador: "Ingresa un texto valido",
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: InputText(
                  topLabelText: "Costo Anterior",
                  handle: (value) =>
                      _formAddToInventary.lastCost = double.parse(value),
                  hintText: "Nombre del producto",
                  validador: "Ingresa un nombre valido",
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: InputText(
                  topLabelText: "Costo Actual",
                  handle: (value) =>
                      _formAddToInventary.actualCost = double.parse(value),
                  hintText: "Marca del producto",
                  validador: "Ingresa una marca valida",
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: InputText(
                  topLabelText: "Categoria",
                  handle: (value) => _formAddToInventary.producto = value,
                  hintText: "Nombre del producto",
                  validador: "Ingresa un nombre valido",
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: InputText(
                  topLabelText: "Proveedor",
                  handle: (value) => _formAddToInventary.brand = value,
                  hintText: "Marca del producto",
                  validador: "Ingresa una marca valida",
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Agregando producto al inventario')),
                  );
                }
              },
              child: const Text('Crear'),
            ),
          ),
        ],
      ),
    );
  }
}
