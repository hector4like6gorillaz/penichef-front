import 'package:base_app/layouts/mainLayoutHOC/main_layout_hoc.dart';
import 'package:base_app/modules/inventary/subModules/addToInventary/add_inventary_interactor.dart';
import 'package:base_app/modules/inventary/subModules/addToInventary/components/form_add_inventary.dart';
import 'package:flutter/material.dart';

class AddInventaryUi extends StatelessWidget {
  const AddInventaryUi({
    super.key,
    required this.interactor,
  });
  final AddInventaryInteractor interactor;

  @override
  Widget build(BuildContext context) {
    return MainLayoutHOC(
        showAppbar: true,
        back: true,
        title: "Agregar nuevo producto al inventario",
        children: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: const Column(
              children: [
                AddToInventary(),
              ],
            ),
          ),
        ));
  }
}
