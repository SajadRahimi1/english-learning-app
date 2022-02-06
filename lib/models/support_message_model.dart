import 'dart:convert';

List<SupportMessageModel> supportMessageFromJson(String str) =>
    List<SupportMessageModel>.from(
        json.decode(str).map((x) => SupportMessageModel.fromJson(x)));

class SupportMessageModel {
  SupportMessageModel({
    required this.id,
    required this.type,
    required this.user,
    required this.message,
    required this.createdAt,
    required this.jalaliCreatedAt,
  });

  final String id;
  final String type;
  final String user;
  final String message;
  final DateTime createdAt;
  final String jalaliCreatedAt;

  factory SupportMessageModel.fromJson(Map<String, dynamic> json) =>
      SupportMessageModel(
        id: json["_id"],
        type: json["type"],
        user: json["user"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        jalaliCreatedAt: json["jalaliCreatedAt"],
      );
}
