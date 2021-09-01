// To parse this JSON data, do
//
//     final daleteCategory = daleteCategoryFromJson(jsonString);

import 'dart:convert';

DaleteCategory daleteCategoryFromJson(String str) => DaleteCategory.fromJson(json.decode(str));

String daleteCategoryToJson(DaleteCategory data) => json.encode(data.toJson());

class DaleteCategory {
  DaleteCategory({
    required this.message,
  });

  String message;

  factory DaleteCategory.fromJson(Map<String, dynamic> json) => DaleteCategory(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
