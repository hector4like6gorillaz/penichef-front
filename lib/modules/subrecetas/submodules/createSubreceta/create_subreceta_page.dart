import 'package:base_app/modules/subrecetas/bloc/subrecetas_bloc.dart';
import 'package:base_app/modules/subrecetas/models/ingredients_create_subreceta_model.dart';
import 'package:base_app/modules/subrecetas/submodules/createSubreceta/create_subreceta_interactor.dart';
import 'package:base_app/modules/subrecetas/submodules/createSubreceta/create_subreceta_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateSubrecetaPage extends StatefulWidget {
  const CreateSubrecetaPage({super.key});

  @override
  State<CreateSubrecetaPage> createState() => _CreateSubrecetaPageState();
}

class _CreateSubrecetaPageState extends State<CreateSubrecetaPage>
    implements CreateSubrecetaInteractor {
  @override
  void initState() {
    BlocProvider.of<SubrecetasBloc>(context)
        .add(GetInventaryInitSubrecetasEvent());
    //on<GetInventaryInSubrecetasByPageEvent>(_getInventaryByPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CreateSubrecetaUi(
      interactor: this,
    );
  }

  @override
  void getInfinityInventary({required String next, required Function reset}) {
    BlocProvider.of<SubrecetasBloc>(context)
        .add(GetMoreInventaryEvent(page: next, reset: reset));
  }

  @override
  void addIngredientInSub({
    required IngredientInSubreceta ingredient,
    required double finalWeight,
  }) {
    BlocProvider.of<SubrecetasBloc>(context).add(AddIngredientInSubrecetaEvent(
      ingredient: ingredient,
      finalWeight: finalWeight,
    ));
  }

  @override
  void modIngredientInSub({
    required String id,
    required double amount,
  }) {
    BlocProvider.of<SubrecetasBloc>(context).add(ModIngredientInSubrecetaEvent(
      amount: amount,
      id: id,
    ));
  }

  @override
  void modFormSubreceta({
    required int id,
    required dynamic value,
  }) {
    BlocProvider.of<SubrecetasBloc>(context).add(ModFormSubrecetaEvent(
      id: id,
      value: value,
    ));
  }

  @override
  void createSubreceta() {
    BlocProvider.of<SubrecetasBloc>(context).add(CreateSubrecetaEvent());
  }
}
