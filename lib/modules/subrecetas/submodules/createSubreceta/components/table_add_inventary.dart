import 'package:base_app/modules/inventary/models/inventary_model.dart';
import 'package:base_app/modules/subrecetas/submodules/createSubreceta/create_subreceta_interactor.dart';
import 'package:base_app/utils/constans.dart';
import 'package:flutter/material.dart';

class TableAddInventary extends StatefulWidget {
  const TableAddInventary({
    super.key,
    required this.data,
    required this.interactor,
    required this.addToIngredients,
  });
  final InventaryData data;
  final CreateSubrecetaInteractor interactor;
  final Function(InventaryProduct) addToIngredients;

  @override
  State<TableAddInventary> createState() => _TableAddInventaryState();
}

class _TableAddInventaryState extends State<TableAddInventary> {
  final ScrollController _scrollController = ScrollController();
  //final TextEditingController _txtContoller = TextEditingController();

  bool _isLoading = false;
  void reset() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 10 &&
          !_isLoading) {
        setState(() {
          _isLoading = true;
        });
        if (widget.data.pagination.nextPage != null) {
          widget.interactor.getInfinityInventary(
              next: widget.data.pagination.nextPage!, reset: reset);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const columnsWidth = {
      0: FixedColumnWidth(200),
      1: FixedColumnWidth(100),
      2: FixedColumnWidth(100),
      3: FixedColumnWidth(200),
      4: FixedColumnWidth(70),
    };
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
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
                    TitleCellConfigHOC(title: "PRECIO\nUNITARIO"),
                    TitleCellConfigHOC(title: "MEDIDA"),
                    TitleCellConfigHOC(title: "PROVEEDOR"),
                    TitleCellConfigHOC(title: "ADD"),
                  ]),
            ],
          ),
          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Table(
                border: TableBorder.symmetric(
                    inside: BorderSide(color: Colors.grey[300]!)),
                columnWidths: columnsWidth,
                children: getRowsCustom(
                  data: widget.data,
                  addToList: widget.addToIngredients,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TableRow> getRowsCustom({
    required InventaryData data,
    required Function(InventaryProduct) addToList,
  }) {
    List<TableRow> rows = [];

    bool changeColor = false;
    Color colorear = Colors.white;
    for (var element in data.results) {
      if (changeColor) {
        colorear = Colors.grey[200]!;
      } else {
        colorear = Colors.white;
      }
      rows.add(
        TableRow(children: [
          ContentCellConfigHOC(
            title: element.product,
            color: colorear,
          ),
          ContentCellConfigHOC(
              title: element.unitaryCostActually.toString(), color: colorear),
          ContentCellConfigHOC(
              title: element.unitOfMeasurement.toString(), color: colorear),
          ContentCellConfigHOC(title: element.provider, color: colorear),
          ContentCellConfigHOC(
            color: colorear,
            children: IconButton(
                onPressed: () {
                  addToList(element);
                },
                icon: const Icon(
                  Icons.format_list_bulleted_add,
                  color: Colors.blue,
                )),
          ),
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
