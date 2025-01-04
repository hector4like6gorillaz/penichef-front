import 'package:base_app/modules/subrecetas/bloc/subrecetas_bloc.dart';

import 'package:base_app/modules/subrecetas/subrecetas_interactor.dart';
import 'package:base_app/modules/subrecetas/subrecetas_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubrecetasPage extends StatefulWidget {
  const SubrecetasPage({super.key});

  @override
  State<SubrecetasPage> createState() => _SubrecetasPageState();
}

class _SubrecetasPageState extends State<SubrecetasPage>
    implements SubrecetasInteractor {
  @override
  void initState() {
    BlocProvider.of<SubrecetasBloc>(context).add(GetSubrecetasInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SubrecetasUi(
      interactor: this,
    );
  }

  @override
  void getSubrecetasListByPage(String page) {
    BlocProvider.of<SubrecetasBloc>(context)
        .add(GetSubrecetasByPageEvent(page: page));
  }
}
