import 'dart:convert';

CalculusSubreceta calculusSubrecetaFromJson(String str) =>
    CalculusSubreceta.fromJson(json.decode(str));

String calculusSubrecetaToJson(CalculusSubreceta data) =>
    json.encode(data.toJson());

class CalculusSubreceta {
  final double totalRawMaterial;
  final double errorMargin;
  final double totalCostOfPreparation;
  final double porcionCost;
  final double gramarCost;

  const CalculusSubreceta({
    this.totalRawMaterial = 0,
    this.errorMargin = 0,
    this.totalCostOfPreparation = 0,
    this.porcionCost = 0,
    this.gramarCost = 0,
  });

  factory CalculusSubreceta.fromJson(Map<String, dynamic> json) =>
      CalculusSubreceta(
        totalRawMaterial: json["totalRawMaterial"]?.toDouble(),
        errorMargin: json["errorMargin"]?.toDouble(),
        totalCostOfPreparation: json["totalCostOfPreparation"]?.toDouble(),
        porcionCost: json["porcionCost"]?.toDouble(),
        gramarCost: json["gramarCost"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "totalRawMaterial": totalRawMaterial,
        "errorMargin": errorMargin,
        "totalCostOfPreparation": totalCostOfPreparation,
        "porcionCost": porcionCost,
        "gramarCost": gramarCost,
      };
}
