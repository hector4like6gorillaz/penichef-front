import 'package:base_app/components/button/buttom.dart';
import 'package:base_app/components/inputText/input_text.dart';
import 'package:base_app/layouts/mainLayoutHOC/main_layout_hoc.dart';
import 'package:base_app/layouts/mainLayoutHOC/modal_hoc.dart';
import 'package:base_app/modules/inventary/models/inventary_model.dart';
import 'package:base_app/modules/subrecetas/bloc/subrecetas_bloc.dart';
import 'package:base_app/modules/subrecetas/models/ingredients_create_subreceta_model.dart';
import 'package:base_app/modules/subrecetas/submodules/createSubreceta/components/table_add_inventary.dart';
import 'package:base_app/modules/subrecetas/submodules/createSubreceta/components/table_inventary_added.dart';
import 'package:base_app/modules/subrecetas/submodules/createSubreceta/create_subreceta_interactor.dart';
import 'package:base_app/utils/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateSubrecetaUi extends StatefulWidget {
  const CreateSubrecetaUi({
    super.key,
    required this.interactor,
  });
  final CreateSubrecetaInteractor interactor;

  @override
  State<CreateSubrecetaUi> createState() => _CreateSubrecetaUiState();
}

class _CreateSubrecetaUiState extends State<CreateSubrecetaUi> {
  bool showModalAddInventary = false;
  final _formKey = GlobalKey<FormState>();

  void changeModal() {
    setState(() {
      showModalAddInventary = !showModalAddInventary;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<SubrecetasBloc, SubrecetasState>(
      builder: (context, state) {
        return Stack(
          children: [
            MainLayoutHOC(
              showAppbar: true,
              back: true,
              title: "AGREGAR SUBRECETA",
              children: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InputText(
                                topLabelText: "Nombre de la subreceta",
                                handle: (value) => widget.interactor
                                    .modFormSubreceta(id: 0, value: value),
                                hintText: "Nombre del producto",
                                validador: "Ingresa un nombre valido",
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: InputText(
                                topLabelText: "Peso final del producto",
                                handle: (value) {
                                  double? number = double.tryParse(value);

                                  if (number != null) {
                                    widget.interactor
                                        .modFormSubreceta(id: 1, value: number);
                                  } else {
                                    // El valor no es un número válido
                                    //print("El valor no es un número válido");
                                  }
                                },
                                hintText: "Marca del producto",
                                validador: "Ingresa una marca valida",
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: InputText(
                                topLabelText: "Unidad de medida",
                                handle: (value) => widget.interactor
                                    .modFormSubreceta(id: 2, value: value),
                                hintText: "Marca del producto",
                                validador: "Ingresa una marca valida",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Button(
                            fn: changeModal,
                            text: "Agregar ingrediente a la lista"),
                        const SizedBox(height: 40),
                        AddedIngredientsTable(
                          listOfIngredients: state.listOfIngredients,
                          interactor: widget.interactor,
                        ),
                        const SizedBox(height: 40),
                        Text(state.formSubreceta.totalRawMaterial.toString()),
                        Text(state.formSubreceta.errorMargin.toString()),
                        Text(state.formSubreceta.totalCostOfPreparation
                            .toString()),
                        Text(state.formSubreceta.porcionCost.toString()),
                        Text(state.formSubreceta.gramarCost.toString()),
                        Button(
                            fn: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Agregando producto al inventario')),
                                );
                                widget.interactor.createSubreceta();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Error, llenar los campos')),
                                );
                              }
                            },
                            text: "CREAR SUBRECETA")
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (showModalAddInventary)
              ModalHOC(
                close: changeModal,
                children: [
                  const Text(
                    "Lista de inventario",
                    style: textMediumStyle,
                  ),
                  Container(
                    color: Colors.transparent,
                    width: size.width / 2,
                    child: Column(
                      children: [
                        if (state.inventaryData != null)
                          TableAddInventary(
                            interactor: widget.interactor,
                            data: state.inventaryData!,
                            addToIngredients: (InventaryProduct p0) {
                              widget.interactor.addIngredientInSub(
                                  ingredient: IngredientInSubreceta(
                                    id: p0.id,
                                    ingredient: p0,
                                    quanty: 1,
                                    totalPrice: p0.unitaryCostActually,
                                  ),
                                  finalWeight: 5);
                            },
                          )
                      ],
                    ),
                  ),
                ],
              )
          ],
        );
      },
    );
  }
}
