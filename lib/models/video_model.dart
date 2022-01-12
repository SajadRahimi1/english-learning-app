// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

VideoModel videoModelFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));

class VideoModel {
  VideoModel({
    required this.items,
    required this.id,
    required this.title,
    required this.faTitle,
    required this.imagePath,
    required this.type,
  });

  final List<Item> items;
  final String id;
  final String title;
  final String faTitle;
  final String imagePath;
  final String type;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        id: json["_id"],
        title: json["title"],
        faTitle: json["faTitle"],
        imagePath: json["imagePath"],
        type: json["type"],
      );
}

class Item {
  Item({required this.title, required this.videoPath, required this.id});

  final String title;
  final String videoPath;
  final String id;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        id: json["_id"],
        videoPath: json["videoPath"],
      );
}
