// To parse this JSON data, do
//
//     final categoryAddModel = categoryAddModelFromJson(jsonString);

import 'dart:convert';

CategoryAddModel categoryAddModelFromJson(String str) => CategoryAddModel.fromJson(json.decode(str));

String categoryAddModelToJson(CategoryAddModel data) => json.encode(data.toJson());

class CategoryAddModel {
  CategoryAddModel({
    required this.message,
    required this.data,
  });

  String message;
  Data data;

  factory CategoryAddModel.fromJson(Map<String, dynamic> json) => CategoryAddModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.categoryId,
    required this.categoryName,
  });

  int categoryId;
  String categoryName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
  };
}
