// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
  CategoriesModel({
    required this.videos,
    required this.page,
    required this.limit,
    required this.count,
    required this.totalCount,
  });

  List<Video> videos;
  int page;
  int limit;
  int count;
  int totalCount;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
    page: json["page"],
    limit: json["limit"],
    count: json["count"],
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
    "page": page,
    "limit": limit,
    "count": count,
    "total_count": totalCount,
  };
}

class Video {
  Video({
    required this.categoryId,
    required this.name,
  });

  int categoryId;
  String name;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    categoryId: json["category_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "name": name,
  };
}
