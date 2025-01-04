import 'package:base_app/modules/inventary/bloc/inventary_bloc.dart';
import 'package:base_app/modules/inventary/inventary_interface.dart';
import 'package:base_app/modules/inventary/inventary_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventaryPage extends StatefulWidget {
  const InventaryPage({super.key});

  @override
  State<InventaryPage> createState() => _InventaryPageState();
}

class _InventaryPageState extends State<InventaryPage>
    implements InventaryInterface {
  @override
  void initState() {
    BlocProvider.of<InventaryBloc>(context).add(GetInventaryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InventaryUi(
      interactor: this,
    );
  }

  @override
  void nextPage(String next) {
    BlocProvider.of<InventaryBloc>(context)
        .add(GetInventaryPageEvent(ep: next));
  }

  @override
  void prevPage(String prev) {
    BlocProvider.of<InventaryBloc>(context)
        .add(GetInventaryPageEvent(ep: prev));
  }
}
