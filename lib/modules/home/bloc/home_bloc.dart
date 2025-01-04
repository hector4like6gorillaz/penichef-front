import 'dart:async';
import 'dart:convert';

import 'package:base_app/services/api_rest_client.dart';
import 'package:base_app/services/urls.dart';
import 'package:base_app/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/web.dart';
 
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService _apiService = GetIt.I<ApiService>();
  final logger = Logger();
  HomeBloc() : super(const HomeState()) {
    on<HomeEvent>((event, emit) {});
    on<HomeSumaEvent>(_suma);
    on<GetPokemonByIdEvent>(_getPokemonId);
  }
  FutureOr<void> _getPokemonId(
      GetPokemonByIdEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(state: ApiState.loading));

    try {
      final response = await _apiService.SERVICE( 
          method: Method.get, endpoint: Urls.getPokemonById(id: event.id));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        //DateSolicitud dataFecha = DateSolicitud.fromJson(data);

        emit(state.copyWith(
            state: ApiState.success,
            name: data["name"],
            picture: data["sprites"]["front_default"]));
      }
    } catch (e) {
      //emit(DataError(e.toString()));
    }
  }

  FutureOr<void> _suma(HomeSumaEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(state: ApiState.initial));

    switch (event.op) {
      case "+":
        emit(state.copyWith(numero: state.numero + 1));
        break;
      case "-":
        emit(state.copyWith(numero: state.numero - 1));
        break;
      default:
    }
  }
}
