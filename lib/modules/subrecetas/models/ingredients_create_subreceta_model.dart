import 'package:base_app/modules/inventary/models/inventary_model.dart';

class IngredientInSubreceta {
  String id;
  InventaryProduct ingredient;
  double quanty;
  double totalPrice;

  IngredientInSubreceta({
    required this.id,
    required this.ingredient,
    required this.quanty,
    required this.totalPrice,
  });
}
