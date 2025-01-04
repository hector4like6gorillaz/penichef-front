import 'dart:convert';

SubrecetasData subrecetasDataFromJson(String str) =>
    SubrecetasData.fromJson(json.decode(str));

String subrecetasDataToJson(SubrecetasData data) => json.encode(data.toJson());

class SubrecetasData {
  List<ResultSubrecetas> results;
  Pagination pagination;

  SubrecetasData({
    required this.results,
    required this.pagination,
  });

  factory SubrecetasData.fromJson(Map<String, dynamic> json) => SubrecetasData(
        results: List<ResultSubrecetas>.from(
            json["results"].map((x) => ResultSubrecetas.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class Pagination {
  int perPage;
  int currentPage;
  int totalPages;
  int totalItems;
  String? nextPage;
  String? prevPage;

  Pagination({
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.nextPage,
    required this.prevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        perPage: json["perPage"],
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        totalItems: json["totalItems"],
        nextPage: json["nextPage"],
        prevPage: json["prevPage"],
      );

  Map<String, dynamic> toJson() => {
        "perPage": perPage,
        "currentPage": currentPage,
        "totalPages": totalPages,
        "totalItems": totalItems,
        "nextPage": nextPage,
        "prevPage": prevPage,
      };
}

class ResultSubrecetas {
  String id;
  String name;
  double finalProductWeight;
  String unitOfMeasurement;
  List<InventaryRecipe> inventaryRecipe;
  double totalRawMaterial;
  double errorMargin;
  double totalCostOfPreparation;
  double porcionCost;
  double gramarCost;
  String createdAt;
  String updatedAt;

  ResultSubrecetas({
    required this.id,
    required this.name,
    required this.finalProductWeight,
    required this.unitOfMeasurement,
    required this.inventaryRecipe,
    required this.totalRawMaterial,
    required this.errorMargin,
    required this.totalCostOfPreparation,
    required this.porcionCost,
    required this.gramarCost,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ResultSubrecetas.fromJson(Map<String, dynamic> json) =>
      ResultSubrecetas(
        id: json["_id"],
        name: json["name"],
        finalProductWeight: (json["finalProductWeight"] as num).toDouble(),
        unitOfMeasurement: json["unitOfMeasurement"],
        inventaryRecipe: List<InventaryRecipe>.from(
            json["inventaryRecipe"].map((x) => InventaryRecipe.fromJson(x))),
        totalRawMaterial: (json["totalRawMaterial"] as num).toDouble(),
        errorMargin: (json["errorMargin"] as num).toDouble(),
        totalCostOfPreparation:
            (json["totalCostOfPreparation"] as num).toDouble(),
        porcionCost: (json["porcionCost"] as num).toDouble(),
        gramarCost: (json["gramarCost"] as num).toDouble(),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "finalProductWeight": finalProductWeight,
        "unitOfMeasurement": unitOfMeasurement,
        "inventaryRecipe":
            List<dynamic>.from(inventaryRecipe.map((x) => x.toJson())),
        "totalRawMaterial": totalRawMaterial,
        "errorMargin": errorMargin,
        "totalCostOfPreparation": totalCostOfPreparation,
        "porcionCost": porcionCost,
        "gramarCost": gramarCost,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class InventaryRecipe {
  String idInventary;
  double amount;

  InventaryRecipe({
    required this.idInventary,
    required this.amount,
  });

  factory InventaryRecipe.fromJson(Map<String, dynamic> json) =>
      InventaryRecipe(
        idInventary: json["idInventary"],
        amount: (json["amount"] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "idInventary": idInventary,
        "amount": amount,
      };
}
