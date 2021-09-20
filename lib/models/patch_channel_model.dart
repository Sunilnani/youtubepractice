// To parse this JSON data, do
//
//     final patchChannel = patchChannelFromJson(jsonString);

import 'dart:convert';

PatchChannel patchChannelFromJson(String str) => PatchChannel.fromJson(json.decode(str));

String patchChannelToJson(PatchChannel data) => json.encode(data.toJson());

class PatchChannel {
  PatchChannel({
    required this.message,
    required this.data,
  });

  String message;
  Data data;

  factory PatchChannel.fromJson(Map<String, dynamic> json) => PatchChannel(
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
    required this.userId,
    required this.channelId,
    required this.categoryId,
    required this.categoryName,
    required this.name,
    required this.bannerUrl,
    required this.profilePicUrl,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  int userId;
  int channelId;
  int categoryId;
  String categoryName;
  String name;
  String bannerUrl;
  String profilePicUrl;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    channelId: json["channel_id"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    name: json["name"],
    bannerUrl: json["banner_url"],
    profilePicUrl: json["profile_pic_url"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "channel_id": channelId,
    "category_id": categoryId,
    "category_name": categoryName,
    "name": name,
    "banner_url": bannerUrl,
    "profile_pic_url": profilePicUrl,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
