import 'package:base_app/modules/home/bloc/home_bloc.dart';
import 'package:base_app/modules/home/home_interactor.dart';
import 'package:base_app/modules/home/home_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomeInteractor {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(const GetPokemonByIdEvent(id: 50));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeUi(
      interactor: this,
    );
  }

  //HomeSumaEvent
  @override
  void getOperation(String op) {
    BlocProvider.of<HomeBloc>(context).add(HomeSumaEvent(op: op));
  }

  @override
  void getPokemonById(int id) {
    BlocProvider.of<HomeBloc>(context).add(GetPokemonByIdEvent(id: id));
  }
}
