import 'dart:async';
import 'dart:convert';

import 'package:base_app/services/api_rest_client.dart';
import 'package:base_app/services/urls.dart';
import 'package:base_app/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/web.dart';

part 'operaciones_event.dart';
part 'operaciones_state.dart';

class OperacionesBloc extends Bloc<OperacionesEvent, OperacionesState> {
  final ApiService _apiService = GetIt.I<ApiService>();
  final logger = Logger();
  OperacionesBloc() : super(const OperacionesState()) {
    on<OperacionesEvent>((event, emit) {});
    on<GetApiEvent>(_getApi);
  }

  FutureOr<void> _getApi(
      GetApiEvent event, Emitter<OperacionesState> emit) async {
    logger.d("hola muchahco");
    emit(state.copyWith(state: ApiState.loading));
    try {
      final response = await _apiService.SERVICE(
          method: Method.get, endpoint: Urls.getMewTwo);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        print(data);

        //DateSolicitud dataFecha = DateSolicitud.fromJson(data);

        emit(state.copyWith(
          state: ApiState.success,
          name: data["name"],
          picture: data["sprites"]["front_default"]
        ));
      }
    } catch (e) {
      //emit(DataError(e.toString()));
    }
  }
}
