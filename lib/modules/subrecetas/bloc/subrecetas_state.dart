part of 'subrecetas_bloc.dart';

class SubrecetasState extends Equatable {
  const SubrecetasState({
    this.state = ApiState.initial,
    this.subrecetasData,
    this.inventaryData,
    this.listOfIngredients = const [],
    this.formSubreceta = const CreateSubreceta(),
  });
  final ApiState state;
  final SubrecetasData? subrecetasData;
  final InventaryData? inventaryData;
  final List<IngredientInSubreceta> listOfIngredients;
  final CreateSubreceta formSubreceta;

  SubrecetasState copyWith({
    ApiState? state,
    SubrecetasData? subrecetasData,
    InventaryData? inventaryData,
    List<IngredientInSubreceta>? listOfIngredients,
    CalculusSubreceta? calculosSubreceta,
    CreateSubreceta? formSubreceta,
  }) {
    return SubrecetasState(
        state: state ?? this.state,
        subrecetasData: subrecetasData ?? this.subrecetasData,
        inventaryData: inventaryData ?? this.inventaryData,
        listOfIngredients: listOfIngredients ?? this.listOfIngredients,
        formSubreceta: formSubreceta ?? this.formSubreceta);
  }

  @override
  List<Object?> get props => [
        state,
        subrecetasData,
        inventaryData,
        listOfIngredients,
        formSubreceta,
      ];
}
