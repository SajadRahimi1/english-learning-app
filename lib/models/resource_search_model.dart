// To parse this JSON data, do
//
//     final resourceSearchModel = resourceSearchModelFromJson(jsonString);

import 'dart:convert';

List<ResourceSearchModel> resourceSearchModelFromJson(String str) =>
    List<ResourceSearchModel>.from(
        json.decode(str).map((x) => ResourceSearchModel.fromJson(x)));

class ResourceSearchModel {
  ResourceSearchModel({
    required this.id,
    required this.title,
    required this.type,
    required this.imagePath,
  });

  final String id;
  final String title;
  final String type;
  final String imagePath;

  factory ResourceSearchModel.fromJson(Map<String, dynamic> json) =>
      ResourceSearchModel(
        id: json["_id"],
        title: json["title"],
        type: json["type"],
        imagePath: json["imagePath"],
      );
}
