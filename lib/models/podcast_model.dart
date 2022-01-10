// To parse this JSON data, do
//
//     final podcastModel = podcastModelFromJson(jsonString);

import 'dart:convert';

PodcastModel podcastModelFromJson(String str) =>
    PodcastModel.fromJson(json.decode(str));

class PodcastModel {
  PodcastModel({
    required this.id,
    required this.faTitle,
    required this.title,
    required this.type,
    required this.items,
    required this.imagePath,
  });

  final String id;
  final String faTitle;
  final String title;
  final String type;
  final List<Item> items;
  final String imagePath;

  factory PodcastModel.fromJson(Map<String, dynamic> json) => PodcastModel(
        id: json["_id"],
        faTitle: json["faTitle"],
        title: json["title"],
        type: json["type"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        imagePath: json["imagePath"],
      );
}

class Item {
  Item({
    required this.title,
    required this.podcastPath,
    required this.id
  });

  final String title;
  final String podcastPath;
  final String id;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        id: json["_id"],
        podcastPath: json["podcastPath"],
      );
}
