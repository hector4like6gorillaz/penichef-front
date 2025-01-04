import 'package:base_app/modules/inventary/models/inventary_model.dart';
import 'package:base_app/modules/inventary/inventary_interface.dart';
import 'package:flutter/material.dart';

class TableInventary extends StatelessWidget {
  const TableInventary({
    super.key,
    required this.data,
    required this.interactor,
  });

  final InventaryData data;
  final InventaryInterface interactor;

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
                  'Producto',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Marca',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Proveedor',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Categoria',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Cantidad',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Unidad de medida',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Costo anterior',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Costo actual',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Costo unitario actual',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Ultima modificación',
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
                        interactor.prevPage(prev);
                      }
                    : null,
                icon: const Icon(Icons.chevron_left),
              ),
              IconButton(
                onPressed: next != null
                    ? () {
                        interactor.nextPage(next);
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

  List<DataRow> getRows(InventaryData data) {
    List<DataRow> rows = [];

    for (var element in data.results) {
      rows.add(DataRow(
        cells: <DataCell>[
          DataCell(Text(element.product)),
          DataCell(Text(element.brand)),
          DataCell(Text(element.provider)),
          DataCell(Text(element.category)),
          DataCell(Text(element.quanty)),
          DataCell(Text(element.unitOfMeasurement)),
          DataCell(Text("${element.lastCost}")),
          DataCell(Text("${element.actualCost}")),
          DataCell(Text("${element.unitaryCostActually}")),
          DataCell(Text(element.updatedAt)),
        ],
      ));
    }

    return rows;
  }
}
