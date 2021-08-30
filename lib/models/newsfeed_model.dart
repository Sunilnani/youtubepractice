// To parse this JSON data, do
//
//     final newsfeedModel = newsfeedModelFromJson(jsonString);

import 'dart:convert';

List<NewsfeedModel> newsfeedModelFromJson(String str) => List<NewsfeedModel>.from(json.decode(str).map((x) => NewsfeedModel.fromJson(x)));

String newsfeedModelToJson(List<NewsfeedModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsfeedModel {
  NewsfeedModel({
    required this.categoryId,
    required this.categoryName,
    required this.channels,
  });

  int categoryId;
  String categoryName;
  List<dynamic> channels;

  factory NewsfeedModel.fromJson(Map<String, dynamic> json) => NewsfeedModel(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    channels: List<dynamic>.from(json["channels"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "channels": List<dynamic>.from(channels.map((x) => x)),
  };
}
