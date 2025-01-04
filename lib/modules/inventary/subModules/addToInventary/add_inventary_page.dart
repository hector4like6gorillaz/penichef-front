import 'package:base_app/modules/inventary/subModules/addToInventary/add_inventary_interactor.dart';
import 'package:base_app/modules/inventary/subModules/addToInventary/add_inventary_ui.dart';
import 'package:flutter/material.dart';

class AddInventaryPage extends StatefulWidget {
  const AddInventaryPage({super.key});

  @override
  State<AddInventaryPage> createState() => _AddInventaryPageState();
}

class _AddInventaryPageState extends State<AddInventaryPage>
    implements AddInventaryInteractor {
  @override
  Widget build(BuildContext context) {
    return AddInventaryUi(
      interactor: this,
    );
  }
}
