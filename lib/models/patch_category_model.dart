// To parse this JSON data, do
//
//     final patchCategory = patchCategoryFromJson(jsonString);

import 'dart:convert';

PatchCategory patchCategoryFromJson(String str) => PatchCategory.fromJson(json.decode(str));

String patchCategoryToJson(PatchCategory data) => json.encode(data.toJson());

class PatchCategory {
  PatchCategory({
    required this.message,
    required this.data,
  });

  String message;
  Data data;

  factory PatchCategory.fromJson(Map<String, dynamic> json) => PatchCategory(
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
    required this.name,
  });

  int categoryId;
  String name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categoryId: json["category_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "name": name,
  };
}
