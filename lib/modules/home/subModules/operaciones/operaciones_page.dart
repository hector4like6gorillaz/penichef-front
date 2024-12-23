import 'package:base_app/modules/home/subModules/bloc/operaciones_bloc.dart';
import 'package:base_app/modules/home/subModules/operaciones/operaciones_interactor.dart';
import 'package:base_app/modules/home/subModules/operaciones/operaciones_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperacionesPage extends StatefulWidget {
  const OperacionesPage({super.key});

  @override
  State<OperacionesPage> createState() => _OperacionesPageState();
}

class _OperacionesPageState extends State<OperacionesPage>
    implements OperacionesInteractor {
  @override
  void initState() {
    BlocProvider.of<OperacionesBloc>(context).add(GetApiEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const OperacionesUi();
  }

  @override
  void getOperation() {
    BlocProvider.of<OperacionesBloc>(context).add(GetApiEvent());
  }
}
