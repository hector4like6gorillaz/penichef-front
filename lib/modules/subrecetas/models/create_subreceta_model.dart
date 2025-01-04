import 'package:base_app/modules/subrecetas/models/subrecetas_list_model.dart';

class CreateSubreceta {
  final String id;
  final String name;
  final double finalProductWeight;
  final String unitOfMeasurement;
  final List<InventaryRecipe> inventaryRecipe;
  final double totalRawMaterial;
  final double errorMargin;
  final double totalCostOfPreparation;
  final double porcionCost;
  final double gramarCost;

  const CreateSubreceta({
    this.id = "",
    this.name = "",
    this.finalProductWeight = 0,
    this.unitOfMeasurement = "",
    this.inventaryRecipe = const [],
    this.totalRawMaterial = 0,
    this.errorMargin = 0,
    this.totalCostOfPreparation = 0,
    this.porcionCost = 0,
    this.gramarCost = 0,
  });
}
