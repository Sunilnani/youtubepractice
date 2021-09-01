// To parse this JSON data, do
//
//     final channelModel = channelModelFromJson(jsonString);

import 'dart:convert';

ChannelModel channelModelFromJson(String str) => ChannelModel.fromJson(json.decode(str));

String channelModelToJson(ChannelModel data) => json.encode(data.toJson());

class ChannelModel {
  ChannelModel({
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

  factory ChannelModel.fromJson(Map<String, dynamic> json) => ChannelModel(
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
    required this.channelId,
    required this.categoryId,
    required this.name,
    required this.banner,
    required this.profilePic,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  int channelId;
  int categoryId;
  String name;
  String banner;
  String profilePic;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    channelId: json["channel_id"],
    categoryId: json["category_id"],
    name: json["name"],
    banner: json["banner"],
    profilePic: json["profile_pic"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "channel_id": channelId,
    "category_id": categoryId,
    "name": name,
    "banner": banner,
    "profile_pic": profilePic,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
