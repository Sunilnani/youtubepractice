// To parse this JSON data, do
//
//     final deleteChannel = deleteChannelFromJson(jsonString);

import 'dart:convert';

DeleteChannel deleteChannelFromJson(String str) => DeleteChannel.fromJson(json.decode(str));

String deleteChannelToJson(DeleteChannel data) => json.encode(data.toJson());

class DeleteChannel {
  DeleteChannel({
    required this.message,
  });

  String message;

  factory DeleteChannel.fromJson(Map<String, dynamic> json) => DeleteChannel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
