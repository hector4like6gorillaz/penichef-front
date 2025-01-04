import 'package:base_app/components/inputText/input_text.dart';
import 'package:base_app/modules/subrecetas/models/ingredients_create_subreceta_model.dart';
import 'package:base_app/modules/subrecetas/submodules/createSubreceta/create_subreceta_interactor.dart';
import 'package:base_app/utils/constans.dart';
import 'package:flutter/material.dart';

class AddedIngredientsTable extends StatelessWidget {
  const AddedIngredientsTable({
    super.key,
    required this.listOfIngredients,
    required this.interactor,
  });
  final List<IngredientInSubreceta> listOfIngredients;
  final CreateSubrecetaInteractor interactor;

  @override
  Widget build(BuildContext context) {
    const columnsWidth = {
      0: FixedColumnWidth(200),
      1: FixedColumnWidth(120),
      2: FixedColumnWidth(200),
      3: FixedColumnWidth(200),
      4: FixedColumnWidth(150),
      5: FixedColumnWidth(150),
    };
    return Column(
      children: [
        Table(
          columnWidths: columnsWidth,
          border: TableBorder.all(color: Colors.grey[300]!),
          children: const [
            TableRow(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                children: [
                  TitleCellConfigHOC(title: "PRODUCTO"),
                  TitleCellConfigHOC(title: "CANTIDAD"),
                  TitleCellConfigHOC(title: "PROVEEDOR"),
                  TitleCellConfigHOC(title: "MEDIDA"),
                  TitleCellConfigHOC(title: "COSTO POR\nUNIDAD"),
                  TitleCellConfigHOC(title: "COSTO TOTAL"),
                ]),
          ],
        ),
        Table(
          border: TableBorder.symmetric(
              inside: BorderSide(color: Colors.grey[300]!)),
          columnWidths: columnsWidth,
          children: getRowsCustom(
            listOfIngredients: listOfIngredients,
            interactor: interactor,
          ),
        ),
      ],
    );
  }

  List<TableRow> getRowsCustom({
    required List<IngredientInSubreceta> listOfIngredients,
    required CreateSubrecetaInteractor interactor,
  }) {
    List<TableRow> rows = [];

    bool changeColor = false;
    Color colorear = Colors.white;
    for (var element in listOfIngredients) {
      if (changeColor) {
        colorear = Colors.grey[200]!;
      } else {
        colorear = Colors.white;
      }
      rows.add(
        TableRow(children: [
          ContentCellConfigHOC(
            title: element.ingredient.product,
            color: colorear,
          ),
          ContentCellConfigHOC(
              color: colorear,
              children: InputText(
                handle: (value) {
                  double? number = double.tryParse(value);

                  if (number != null) {
                    interactor.modIngredientInSub(
                      amount: number,
                      id: element.id,
                    );
                  } else {
                    // El valor no es un número válido
                    //print("El valor no es un número válido");
                  }
                },
                initialValue: element.quanty.toString(),
              )),
          ContentCellConfigHOC(
              title: element.ingredient.provider, color: colorear),
          ContentCellConfigHOC(
              title: element.ingredient.unitOfMeasurement, color: colorear),
          ContentCellConfigHOC(
              title: element.ingredient.unitaryCostActually.toString(),
              color: colorear),
          ContentCellConfigHOC(
              title: element.totalPrice.toString(), color: colorear),
        ]),
      );
      changeColor = !changeColor;
    }

    return rows;
  }
}

class TitleCellConfigHOC extends StatelessWidget {
  const TitleCellConfigHOC({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        height: 65,
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: textSmallStyle.copyWith(color: Colors.white),
            ),
          ],
        ));
  }
}

class ContentCellConfigHOC extends StatelessWidget {
  const ContentCellConfigHOC({
    super.key,
    this.title,
    this.color = Colors.white,
    this.children,
  });
  final String? title;
  final Color color;
  final Widget? children;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: color,
        height: 50,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (children != null) children!,
            if (title != null)
              Text(
                title!,
                style: textSmallStyle.copyWith(color: Colors.black),
              ),
          ],
        ));
  }
}
