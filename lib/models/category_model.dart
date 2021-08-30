// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

// import 'dart:convert';
//
// CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));
//
// String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());
//
// class CategoryModel {
//   CategoryModel({
//     required this.videos,
//     required this.page,
//     required this.limit,
//     required this.count,
//     required this.totalCount,
//   });
//
//   List<Video> videos;
//   int page;
//   int limit;
//   int count;
//   int totalCount;
//
//   factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
//     videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
//     page: json["page"],
//     limit: json["limit"],
//     count: json["count"],
//     totalCount: json["total_count"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
//     "page": page,
//     "limit": limit,
//     "count": count,
//     "total_count": totalCount,
//   };
// }
//
// class Video {
//   Video({
//     required this.categoryId,
//     required this.name,
//   });
//
//   int categoryId;
//   String name;
//
//   factory Video.fromJson(Map<String, dynamic> json) => Video(
//     categoryId: json["category_id"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "category_id": categoryId,
//     "name": name,
//   };
// }


// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.categoryId,
    required this.categoryName,
  });

  int categoryId;
  String categoryName;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
  };
}

