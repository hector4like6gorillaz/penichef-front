import 'dart:async';
import 'dart:convert';

import 'package:base_app/modules/inventary/models/inventary_model.dart';
import 'package:base_app/modules/subrecetas/models/calculus_subreceta.dart';
import 'package:base_app/modules/subrecetas/models/create_subreceta_model.dart';
import 'package:base_app/modules/subrecetas/models/ingredients_create_subreceta_model.dart';
import 'package:base_app/modules/subrecetas/models/subrecetas_list_model.dart';
import 'package:base_app/services/api_rest_client.dart';
import 'package:base_app/services/urls.dart';
import 'package:base_app/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/web.dart';

part 'subrecetas_event.dart';
part 'subrecetas_state.dart';

class SubrecetasBloc extends Bloc<SubrecetasEvent, SubrecetasState> {
  final ApiService _apiService = GetIt.I<ApiService>();
  final logger = Logger();
  SubrecetasBloc() : super(const SubrecetasState()) {
    on<SubrecetasEvent>((event, emit) {});
    on<GetSubrecetasInitEvent>(_getSubRecetasInit);
    on<GetSubrecetasByPageEvent>(_getSubRecetasByPage);
    on<GetInventaryInitSubrecetasEvent>(_getInventaryInitial);
    on<GetMoreInventaryEvent>(_getMoreInventary);
    on<AddIngredientInSubrecetaEvent>(_addIngredientInSubreceta);
    on<ModIngredientInSubrecetaEvent>(_addModIngredient);
    on<ModFormSubrecetaEvent>(_modFormSubreceta);
    on<CreateSubrecetaEvent>(_createSubreceta);
  }

  FutureOr<void> _createSubreceta(
      CreateSubrecetaEvent event, Emitter<SubrecetasState> emit) async {
    emit(state.copyWith(state: ApiState.loading));

    dynamic body = {
      "name": state.formSubreceta.name,
      "finalProductWeight": state.formSubreceta.finalProductWeight,
      "unitOfMeasurement": state.formSubreceta.unitOfMeasurement,
      "inventaryRecipe": state.formSubreceta.inventaryRecipe,
      "totalRawMaterial": state.formSubreceta.totalRawMaterial,
      "errorMargin": state.formSubreceta.errorMargin,
      "totalCostOfPreparation": state.formSubreceta.totalCostOfPreparation,
      "porcionCost": state.formSubreceta.porcionCost,
      "gramarCost": state.formSubreceta.gramarCost
    };

    try {
      final response = await _apiService.SERVICE(
          method: Method.post, endpoint: Urls.subrecetas, body: body);
      if (response.statusCode == 201) {
        Map<String, dynamic> data = jsonDecode(response.body);
        //SubrecetasData subrecetas = SubrecetasData.fromJson(data);
        logger.f(data);

        emit(state.copyWith(
          state: ApiState.success,
          //subrecetasData: subrecetas,
        ));
      }
    } catch (e) {
      //emit(DataError(e.toString()));
    }
  }

  FutureOr<void> _modFormSubreceta(
    ModFormSubrecetaEvent event,
    Emitter<SubrecetasState> emit,
  ) async {
    CreateSubreceta formActual = state.formSubreceta;

    switch (event.id) {
      case 0:
        formActual = CreateSubreceta(
          name: event.value,
          finalProductWeight: formActual.finalProductWeight,
          unitOfMeasurement: formActual.unitOfMeasurement,
          inventaryRecipe: formActual.inventaryRecipe,
          totalRawMaterial: formActual.totalRawMaterial,
          errorMargin: formActual.errorMargin,
          totalCostOfPreparation: formActual.totalCostOfPreparation,
          gramarCost: formActual.gramarCost,
          porcionCost: formActual.porcionCost,
        );
        break;
      case 1:
        formActual = CreateSubreceta(
          name: formActual.name,
          finalProductWeight: event.value,
          unitOfMeasurement: formActual.unitOfMeasurement,
          inventaryRecipe: formActual.inventaryRecipe,
          totalRawMaterial: formActual.totalRawMaterial,
          errorMargin: formActual.errorMargin,
          totalCostOfPreparation: formActual.totalCostOfPreparation,
          gramarCost: formActual.gramarCost,
          porcionCost: formActual.porcionCost,
        );
        break;
      case 2:
        formActual = CreateSubreceta(
          name: formActual.name,
          finalProductWeight: formActual.finalProductWeight,
          unitOfMeasurement: event.value,
          inventaryRecipe: formActual.inventaryRecipe,
          totalRawMaterial: formActual.totalRawMaterial,
          errorMargin: formActual.errorMargin,
          totalCostOfPreparation: formActual.totalCostOfPreparation,
          gramarCost: formActual.gramarCost,
          porcionCost: formActual.porcionCost,
        );
        break;

      default:
    }

    emit(state.copyWith(
      state: ApiState.loading,
      formSubreceta: formActual,
    ));
  }

  FutureOr<void> _addModIngredient(
    ModIngredientInSubrecetaEvent event,
    Emitter<SubrecetasState> emit,
  ) async {
    //emit(state.copyWith(state: ApiState.loading));
    logger.i(
        "${state.formSubreceta.finalProductWeight} ${state.formSubreceta.name} ${state.formSubreceta.unitOfMeasurement}");

    List<IngredientInSubreceta> listOfIngredients = [
      ...state.listOfIngredients
    ];

    IngredientInSubreceta modIngredient = listOfIngredients.firstWhere(
      (element) => element.id == event.id,
    );
    listOfIngredients =
        listOfIngredients.where((element) => element.id != event.id).toList();

    modIngredient.totalPrice =
        event.amount * modIngredient.ingredient.unitaryCostActually;

    listOfIngredients.add(IngredientInSubreceta(
      id: modIngredient.id,
      ingredient: modIngredient.ingredient,
      quanty: event.amount,
      totalPrice: double.parse(modIngredient.totalPrice.toStringAsFixed(2)),
    ));

    listOfIngredients.sort(
      (a, b) => a.ingredient.product.compareTo(b.ingredient.product),
    );

    CreateSubreceta formActual = state.formSubreceta;

    List<InventaryRecipe> inventaryRecipe = state.listOfIngredients
        .map((e) => InventaryRecipe(amount: e.quanty, idInventary: e.id))
        .toList();

    formActual = CreateSubreceta(
      name: formActual.name,
      finalProductWeight: formActual.finalProductWeight,
      unitOfMeasurement: formActual.unitOfMeasurement,
      inventaryRecipe: inventaryRecipe,
      totalRawMaterial: formActual.totalRawMaterial,
      errorMargin: formActual.errorMargin,
      totalCostOfPreparation: formActual.totalCostOfPreparation,
      gramarCost: formActual.gramarCost,
      porcionCost: formActual.porcionCost,
    );
    emit(state.copyWith(
      listOfIngredients: listOfIngredients,
      state: ApiState.loading,
      formSubreceta: formActual,
    ));
    if (state.formSubreceta.finalProductWeight != 0) {
      try {
        dynamic inventaryRecipe = [];

        for (var element in listOfIngredients) {
          inventaryRecipe
              .add({"idInventary": element.id, "amount": element.quanty});
        }

        dynamic body = {"inventaryRecipe": inventaryRecipe};

        final response = await _apiService.SERVICE(
            method: Method.post,
            endpoint: Urls.calculateWithInventarySubreceta(
                finalWeight: state.formSubreceta.finalProductWeight),
            body: body);
        if (response.statusCode == 201) {
          Map<String, dynamic> data = jsonDecode(response.body);

          CalculusSubreceta calculos = CalculusSubreceta.fromJson(data);

          CreateSubreceta newForm = CreateSubreceta(
            name: state.formSubreceta.name,
            finalProductWeight: state.formSubreceta.finalProductWeight,
            unitOfMeasurement: state.formSubreceta.unitOfMeasurement,
            inventaryRecipe: state.formSubreceta.inventaryRecipe,
            totalRawMaterial: calculos.totalRawMaterial,
            errorMargin: calculos.errorMargin,
            totalCostOfPreparation: calculos.totalCostOfPreparation,
            porcionCost: calculos.porcionCost,
            gramarCost: calculos.gramarCost,
          );

          emit(state.copyWith(
            state: ApiState.success,
            formSubreceta: newForm,
          ));
        }
      } catch (e) {
        //emit(DataError(e.toString()));
      }
    } else {
      print("no me cumplo");
    }
  }

  FutureOr<void> _addIngredientInSubreceta(
    AddIngredientInSubrecetaEvent event,
    Emitter<SubrecetasState> emit,
  ) async {
    //emit(state.copyWith(state: ApiState.loading));

    List<IngredientInSubreceta> listOfIngredients = [
      ...state.listOfIngredients
    ];

    listOfIngredients.add(event.ingredient);

    listOfIngredients.sort(
      (a, b) => a.ingredient.product.compareTo(b.ingredient.product),
    );

    CreateSubreceta formActual = state.formSubreceta;

    List<InventaryRecipe> inventaryRecipe = state.listOfIngredients
        .map((e) => InventaryRecipe(amount: e.quanty, idInventary: e.id))
        .toList();

    formActual = CreateSubreceta(
      name: formActual.name,
      finalProductWeight: formActual.finalProductWeight,
      unitOfMeasurement: formActual.unitOfMeasurement,
      inventaryRecipe: inventaryRecipe,
      totalRawMaterial: formActual.totalRawMaterial,
      errorMargin: formActual.errorMargin,
      totalCostOfPreparation: formActual.totalCostOfPreparation,
      gramarCost: formActual.gramarCost,
      porcionCost: formActual.porcionCost,
    );
    emit(state.copyWith(
      listOfIngredients: listOfIngredients,
      state: ApiState.loading,
      formSubreceta: formActual,
    ));
    if (state.formSubreceta.finalProductWeight != 0) {
      try {
        dynamic inventaryRecipe = [];

        for (var element in listOfIngredients) {
          inventaryRecipe
              .add({"idInventary": element.id, "amount": element.quanty});
        }

        dynamic body = {"inventaryRecipe": inventaryRecipe};

        final response = await _apiService.SERVICE(
            method: Method.post,
            endpoint: Urls.calculateWithInventarySubreceta(finalWeight: 5),
            body: body);
        if (response.statusCode == 201) {
          Map<String, dynamic> data = jsonDecode(response.body);

          CalculusSubreceta calculos = CalculusSubreceta.fromJson(data);
          CreateSubreceta newForm = CreateSubreceta(
            name: state.formSubreceta.name,
            finalProductWeight: state.formSubreceta.finalProductWeight,
            unitOfMeasurement: state.formSubreceta.unitOfMeasurement,
            inventaryRecipe: state.formSubreceta.inventaryRecipe,
            totalRawMaterial: calculos.totalRawMaterial,
            errorMargin: calculos.errorMargin,
            totalCostOfPreparation: calculos.totalCostOfPreparation,
            porcionCost: calculos.porcionCost,
            gramarCost: calculos.gramarCost,
          );

          emit(state.copyWith(
            state: ApiState.success,
            formSubreceta: newForm,
          ));
        }
      } catch (e) {
        //emit(DataError(e.toString()));
      }
    }
  }

  FutureOr<void> _getMoreInventary(
    GetMoreInventaryEvent event,
    Emitter<SubrecetasState> emit,
  ) async {
    emit(state.copyWith(state: ApiState.loading));

    try {
      final response = await _apiService.SERVICE(
          method: Method.get,
          endpoint: Urls.getInventaryByPage(uri: event.page));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        InventaryData inventary = InventaryData.fromJson(data);
        InventaryData newInventary = inventary;
        if (state.inventaryData != null &&
            state.inventaryData!.pagination.currentPage <=
                inventary.pagination.totalPages) {
          newInventary =
              InventaryData(pagination: inventary.pagination, results: [
            ...state.inventaryData!.results,
            ...inventary.results,
          ]);
        }
        emit(state.copyWith(
          state: ApiState.success,
          inventaryData: newInventary,
        ));
        event.reset();
      }
    } catch (e) {
      //emit(DataError(e.toString()));
    }
  }

  FutureOr<void> _getInventaryInitial(GetInventaryInitSubrecetasEvent event,
      Emitter<SubrecetasState> emit) async {
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

  FutureOr<void> _getSubRecetasInit(
      GetSubrecetasInitEvent event, Emitter<SubrecetasState> emit) async {
    emit(state.copyWith(state: ApiState.loading));

    try {
      final response = await _apiService.SERVICE(
          method: Method.get, endpoint: Urls.subrecetas);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        SubrecetasData subrecetas = SubrecetasData.fromJson(data);

        emit(state.copyWith(
          state: ApiState.success,
          subrecetasData: subrecetas,
        ));
      }
    } catch (e) {
      //emit(DataError(e.toString()));
    }
  }

  FutureOr<void> _getSubRecetasByPage(
      GetSubrecetasByPageEvent event, Emitter<SubrecetasState> emit) async {
    emit(state.copyWith(state: ApiState.loading));

    try {
      final response = await _apiService.SERVICE(
          method: Method.get,
          endpoint: Urls.getSubrecetasByPage(uri: event.page));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        SubrecetasData subrecetas = SubrecetasData.fromJson(data);

        emit(state.copyWith(
          state: ApiState.success,
          subrecetasData: subrecetas,
        ));
      }
    } catch (e) {
      //emit(DataError(e.toString()));
    }
  }
}
