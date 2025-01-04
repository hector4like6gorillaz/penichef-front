import 'package:base_app/modules/subrecetas/models/ingredients_create_subreceta_model.dart';

abstract class CreateSubrecetaInteractor {
  void getInfinityInventary({required String next, required Function reset}) {}
  void addIngredientInSub({
    required IngredientInSubreceta ingredient,
    required double finalWeight,
  }) {}
  void modIngredientInSub({
    required String id,
    required double amount,
  }) {}
  void modFormSubreceta({
    required int id,
    required dynamic value,
  }) {}
  void createSubreceta() {}
}
