part of 'subrecetas_bloc.dart';

abstract class SubrecetasEvent extends Equatable {
  const SubrecetasEvent();

  @override
  List<Object> get props => [];
}

class GetSubrecetasInitEvent extends SubrecetasEvent {}

class GetSubrecetasByPageEvent extends SubrecetasEvent {
  final String page;
  const GetSubrecetasByPageEvent({required this.page});
}

class GetInventaryInitSubrecetasEvent extends SubrecetasEvent {}

class GetMoreInventaryEvent extends SubrecetasEvent {
  final String page;
  final Function reset;
  const GetMoreInventaryEvent({
    required this.page,
    required this.reset,
  });
}

class SearchInventaryEvent extends SubrecetasEvent {
  final String search;
  const SearchInventaryEvent({required this.search});
}

class AddIngredientInSubrecetaEvent extends SubrecetasEvent {
  final IngredientInSubreceta ingredient;
  final double finalWeight;
  const AddIngredientInSubrecetaEvent({
    required this.ingredient,
    required this.finalWeight,
  });
}

class ModIngredientInSubrecetaEvent extends SubrecetasEvent {
  final String id;
  final double amount;

  const ModIngredientInSubrecetaEvent({
    required this.id,
    required this.amount,
  });
}

class ModFormSubrecetaEvent extends SubrecetasEvent {
  final int id;
  final dynamic value;
  const ModFormSubrecetaEvent({required this.id, required this.value});
}

class CreateSubrecetaEvent extends SubrecetasEvent {}
