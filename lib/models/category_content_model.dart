// To parse this JSON data, do
//
//     final categoryContent = categoryContentFromJson(jsonString);

import 'dart:convert';

List<CategoryContent> categoryContentFromJson(String str) =>
    List<CategoryContent>.from(
        json.decode(str).map((x) => CategoryContent.fromJson(x)));

class CategoryContent {
  CategoryContent({
    required this.title,
    required this.createdAt,
    required this.bookmark,
    required this.imagePath,
    required this.description,
  });
  final String title;
  final DateTime createdAt;
  final bool bookmark;
  final String imagePath;
  final String description;

  factory CategoryContent.fromJson(Map<String, dynamic> json) =>
      CategoryContent(
        title: json["title"],
        createdAt: DateTime.parse(json["createdAt"]),
        bookmark: json["bookmark"],
        imagePath: json["imagePath"],
        description: json["description"],
      );
}
