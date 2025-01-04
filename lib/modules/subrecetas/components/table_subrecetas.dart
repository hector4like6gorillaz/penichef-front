import 'package:base_app/layouts/mainLayoutHOC/center_row.dart';
import 'package:base_app/modules/subrecetas/models/subrecetas_list_model.dart';
import 'package:base_app/modules/subrecetas/subrecetas_interactor.dart';
import 'package:flutter/material.dart';

class TableSubrecetas extends StatelessWidget {
  const TableSubrecetas({
    super.key,
    required this.data,
    required this.interactor,
  });
  final SubrecetasData data;
  final SubrecetasInteractor interactor;

  @override
  Widget build(BuildContext context) {
    String? next = data.pagination.nextPage;
    String? prev = data.pagination.prevPage;
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'NOMBRE DE LA SUBRECETA',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'PESO FINAL\nDEL\nPRODUCTO',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'UNIDAD DE\nMEDIDA',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'TOTAL\nMATERIA PRIMA',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'MARGEN\nDE ERROR',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'COSTO TOTAL\nDE LA\nPREPARACIÓN',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'COSTO POR\nPORCIÓN',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'COSTO POR\nGRAMOS',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'INGREDIENTES',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'ULTIMA\nMODIFICACIÓN',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ], rows: getRows(data)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: prev != null
                    ? () {
                        interactor.getSubrecetasListByPage(prev);
                      }
                    : null,
                icon: const Icon(Icons.chevron_left),
              ),
              IconButton(
                onPressed: next != null
                    ? () {
                        interactor.getSubrecetasListByPage(next);
                      }
                    : null,
                icon: const Icon(Icons.chevron_right),
              ),
              const SizedBox(width: 16),
              Text(
                  "Pagina ${data.pagination.currentPage} de ${data.pagination.totalPages}")
            ],
          ),
        )
      ],
    );
  }

  List<DataRow> getRows(SubrecetasData data) {
    List<DataRow> rows = [];

    for (var element in data.results) {
      rows.add(DataRow(
        //mouseCursor: WidgetStateMouseCursor.textable,
        //selected: true,
        cells: <DataCell>[
          DataCell(Text(element.name)),
          DataCell(CenterRowHOC(
            children: [
              Text(element.finalProductWeight.toString()),
            ],
          )),
          DataCell(CenterRowHOC(
            children: [
              Text(element.unitOfMeasurement),
            ],
          )),
          DataCell(CenterRowHOC(
            children: [
              Text(element.totalRawMaterial.toString()),
            ],
          )),
          DataCell(CenterRowHOC(
            children: [
              Text(element.errorMargin.toString()),
            ],
          )),
          DataCell(CenterRowHOC(
            children: [
              Text(element.totalCostOfPreparation.toString()),
            ],
          )),
          DataCell(CenterRowHOC(
            children: [
              Text(element.porcionCost.toString()),
            ],
          )),
          DataCell(CenterRowHOC(
            children: [
              Text(element.gramarCost.toString()),
            ],
          )),
          DataCell(CenterRowHOC(
            children: [
              Text(element.inventaryRecipe.length.toString()),
              const SizedBox(width: 10),
              const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Icon(Icons.remove_red_eye_outlined))
            ],
          )),
          DataCell(CenterRowHOC(
            children: [
              Text(element.updatedAt),
            ],
          )),
        ],
      ));
    }

    return rows;
  }
}
