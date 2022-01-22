// To parse this JSON data, do
//
//     final podcastItemModel = podcastItemModelFromJson(jsonString);

import 'dart:convert';

PodcastItemModel podcastItemModelFromJson(String str) =>
    PodcastItemModel.fromJson(json.decode(str));

class PodcastItemModel {
  PodcastItemModel({
    required this.id,
    required this.faTitle,
    required this.title,
    required this.type,
    required this.imagePath,
    required this.paragraphs,
    required this.itemTitle,
    required this.itemFaTitle,
    required this.podcastPath,
  });

  final String id;
  final String faTitle;
  final String title;
  final String type;
  final String imagePath;
  final List<Paragraph> paragraphs;
  final String itemTitle;
  final String itemFaTitle;
  final String podcastPath;

  factory PodcastItemModel.fromJson(Map<String, dynamic> json) =>
      PodcastItemModel(
        id: json["_id"],
        faTitle: json["faTitle"],
        title: json["title"],
        type: json["type"],
        imagePath: json["imagePath"],
        paragraphs: List<Paragraph>.from(
            json["paragraphs"].map((x) => Paragraph.fromJson(x))),
        itemTitle: json["itemTitle"],
        itemFaTitle: json["itemFaTitle"],
        podcastPath: json["podcastPath"],
      );
}

class Paragraph {
  Paragraph({
    required this.id,
    required this.pst,
    required this.fa,
    required this.en,
    required this.startTime,
  });

  final String id;
  final int pst;
  final String fa;
  final String en;
  final String startTime;

  factory Paragraph.fromJson(Map<String, dynamic> json) => Paragraph(
        id: json["_id"],
        pst: json["pst"],
        fa: json["fa"] ?? "",
        en: json["en"] ?? "",
        startTime: json["startTime"],
      );
}
