// To parse this JSON data, do
//
//     final videoItemsModel = videoItemsModelFromJson(jsonString);

import 'dart:convert';

VideoItemsModel videoItemsModelFromJson(String str) =>
    VideoItemsModel.fromJson(json.decode(str));

String videoItemsModelToJson(VideoItemsModel data) =>
    json.encode(data.toJson());

class VideoItemsModel {
  VideoItemsModel({
    required this.paragraphs,
    required this.id,
    required this.title,
    required this.faTitle,
    required this.imagePath,
    required this.itemTitle,
    required this.itemFaTitle,
    required this.videoPath,
    required this.type,
  });

  final List<Paragraph> paragraphs;
  final String id;
  final String title;
  final String faTitle;
  final String imagePath;
  final String itemTitle;
  final String itemFaTitle;
  final String videoPath;
  final String type;

  factory VideoItemsModel.fromJson(Map<String, dynamic> json) =>
      VideoItemsModel(
        paragraphs: List<Paragraph>.from(
            json["paragraphs"].map((x) => Paragraph.fromJson(x))),
        id: json["_id"],
        title: json["title"],
        faTitle: json["faTitle"],
        imagePath: json["imagePath"],
        itemTitle: json["itemTitle"],
        itemFaTitle: json["itemFaTitle"],
        videoPath: json["videoPath"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "paragraphs": List<dynamic>.from(paragraphs.map((x) => x.toJson())),
        "_id": id,
        "title": title,
        "faTitle": faTitle,
        "imagePath": imagePath,
        "itemTitle": itemTitle,
        "itemFaTitle": itemFaTitle,
        "videoPath": videoPath,
        "type": type,
      };
}

class Paragraph {
  Paragraph({
    required this.id,
    required this.en,
    required this.fa,
    required this.pst,
  });

  final String id;
  final String en;
  final String fa;
  final int pst;

  factory Paragraph.fromJson(Map<String, dynamic> json) => Paragraph(
        id: json["_id"],
        en: json["en"],
        fa: json["fa"],
        pst: json["pst"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "en": en,
        "fa": fa,
        "pst": pst,
      };
}
