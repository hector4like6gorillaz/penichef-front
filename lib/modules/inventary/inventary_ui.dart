import 'package:base_app/components/button/buttom.dart';
import 'package:base_app/layouts/mainLayoutHOC/main_layout_hoc.dart';
import 'package:base_app/modules/inventary/bloc/inventary_bloc.dart';
import 'package:base_app/modules/inventary/components/table_inventary.dart';
import 'package:base_app/modules/inventary/inventary_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InventaryUi extends StatelessWidget {
  const InventaryUi({
    super.key,
    required this.interactor,
  });

  final InventaryInterface interactor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventaryBloc, InventaryState>(
      builder: (context, state) {
        return MainLayoutHOC(
            showAppbar: true,
            title: "Inventario",
            children: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 32, top: 32),
                    child: Row(
                      children: [
                        Button(
                          fn: () {
                            context.pushNamed("addInventoryPage");
                          },
                          text: "Agregar producto",
                        )
                      ],
                    ),
                  ),
                  if (state.inventaryData != null)
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            style: BorderStyle.solid,
                          )),
                      margin: const EdgeInsets.all(32),
                      child: TableInventary(
                        data: state.inventaryData!,
                        interactor: interactor,
                      ),
                    )
                ],
              ),
            ));
      },
    );
  }
}
