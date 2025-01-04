import 'dart:async';
import 'dart:convert';

import 'package:base_app/modules/inventary/models/inventary_model.dart';
import 'package:base_app/services/api_rest_client.dart';
import 'package:base_app/services/urls.dart';
import 'package:base_app/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/web.dart';

part 'inventary_event.dart';
part 'inventary_state.dart';

class InventaryBloc extends Bloc<InventaryEvent, InventaryState> {
  final ApiService _apiService = GetIt.I<ApiService>();
  final logger = Logger();
  InventaryBloc() : super(const InventaryState()) {
    on<InventaryEvent>((event, emit) {});
    on<GetInventaryEvent>(_getInventaryInitial);
    on<GetInventaryPageEvent>(_getInventaryByPage);
  }

  FutureOr<void> _getInventaryByPage(
      GetInventaryPageEvent event, Emitter<InventaryState> emit) async {
    emit(state.copyWith(state: ApiState.loading));

    try {
      final response = await _apiService.SERVICE(
          method: Method.get, endpoint: Urls.getInventaryByPage(uri: event.ep));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        InventaryData inventary = InventaryData.fromJson(data);

        emit(state.copyWith(
          state: ApiState.success,
          inventaryData: inventary,
        ));
      }
    } catch (e) {
      //emit(DataError(e.toString()));
    }
  }

  FutureOr<void> _getInventaryInitial(
      GetInventaryEvent event, Emitter<InventaryState> emit) async {
    emit(state.copyWith(state: ApiState.loading));

    try {
      final response = await _apiService.SERVICE(
          method: Method.get, endpoint: Urls.inventary);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        InventaryData inventary = InventaryData.fromJson(data);

        logger.i(inventary);
        emit(state.copyWith(state: ApiState.success, inventaryData: inventary));
      }
    } catch (e) {
      //emit(DataError(e.toString()));
    }
  }
}
