// To parse this JSON data, do
//
//     final newsDetailModel = newsDetailModelFromJson(jsonString);

import 'dart:convert';

NewsDetailModel newsDetailModelFromJson(String str) =>
    NewsDetailModel.fromJson(json.decode(str));

class NewsDetailModel {
  NewsDetailModel({
    required this.id,
    required this.faTitle,
    required this.title,
    required this.paragraphs,
    required this.wordsList,
    required this.bookmark,
    required this.imagePath,
    required this.podcastPath,
  });

  final String id;
  final String faTitle;
  final String title;
  final List<Paragraph> paragraphs;
  final List<dynamic> wordsList;
  final bool bookmark;
  final String imagePath;
  final String podcastPath;

  factory NewsDetailModel.fromJson(Map<String, dynamic> json) =>
      NewsDetailModel(
        id: json["_id"],
        faTitle: json["faTitle"],
        title: json["title"],
        paragraphs: List<Paragraph>.from(
            json["paragraphs"].map((x) => Paragraph.fromJson(x))),
        wordsList: List<dynamic>.from(json["wordsList"].map((x) => x)),
        bookmark: json["bookmark"],
        imagePath: json["imagePath"],
        podcastPath: json["podcastPath"],
      );
}

class Paragraph {
  Paragraph({
    required this.id,
    required this.pst,
    required this.fa,
    required this.en,
  });

  final String id;
  final int pst;
  final String fa;
  final String en;

  factory Paragraph.fromJson(Map<String, dynamic> json) => Paragraph(
        id: json["_id"],
        pst: json["pst"],
        fa: json["fa"],
        en: json["en"],
      );
}
