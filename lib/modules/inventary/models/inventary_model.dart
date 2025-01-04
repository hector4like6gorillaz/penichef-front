// To parse this JSON data, do
//
//     final inventaryData = inventaryDataFromJson(jsonString);

import 'dart:convert';

InventaryData inventaryDataFromJson(String str) =>
    InventaryData.fromJson(json.decode(str));

String inventaryDataToJson(InventaryData data) => json.encode(data.toJson());

class InventaryData {
  List<InventaryProduct> results;
  Pagination pagination;

  InventaryData({
    required this.results,
    required this.pagination,
  });

  factory InventaryData.fromJson(Map<String, dynamic> json) => InventaryData(
        results:
            List<InventaryProduct>.from(json["results"].map((x) => InventaryProduct.fromJson(x))),
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

class InventaryProduct {
  String id;
  String product;
  String brand;
  String provider;
  String category;
  String quanty;
  String unitOfMeasurement;
  double lastCost;
  double actualCost;
  double unitaryCostActually;
  String createdAt;
  String updatedAt;

  InventaryProduct({
    required this.id,
    required this.product,
    required this.brand,
    required this.provider,
    required this.category,
    required this.quanty,
    required this.unitOfMeasurement,
    required this.lastCost,
    required this.actualCost,
    required this.unitaryCostActually,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InventaryProduct.fromJson(Map<String, dynamic> json) => InventaryProduct(
        id: json["_id"],
        product: json["product"],
        brand: json["brand"],
        provider: json["provider"],
        category: json["category"],
        quanty: json["quanty"],
        unitOfMeasurement: json["unitOfMeasurement"],
        lastCost: (json["lastCost"] as num).toDouble(), // Convertir a double
        actualCost: (json["actualCost"] as num).toDouble(),
        unitaryCostActually: (json["unitaryCostActually"] as num).toDouble(),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product": product,
        "brand": brand,
        "provider": provider,
        "category": category,
        "quanty": quanty,
        "unitOfMeasurement": unitOfMeasurement,
        "lastCost": lastCost,
        "actualCost": actualCost,
        "unitaryCostActually": unitaryCostActually,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
