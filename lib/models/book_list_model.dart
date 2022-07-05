// To parse this JSON data, do
//
//     final bookListModel = bookListModelFromJson(jsonString);

import 'dart:convert';

List<BookListModel> bookListModelFromJson(String str) => List<BookListModel>.from(json.decode(str).map((x) => BookListModel.fromJson(x)));

String bookListModelToJson(List<BookListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookListModel {
    BookListModel({
      required  this.id,
      required  this.podcastTime,
      required  this.wordsCount,
      required  this.faTitle,
      required  this.title,
      required  this.imagePath,
    });

    final String id;
    final int podcastTime;
    final int wordsCount;
    final String faTitle;
    final String title;
    final String imagePath;

    factory BookListModel.fromJson(Map<String, dynamic> json) => BookListModel(
        id: json["_id"],
        podcastTime: json["podcastTime"],
        wordsCount: json["wordsCount"],
        faTitle: json["faTitle"],
        title: json["title"],
        imagePath: json["imagePath"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "podcastTime": podcastTime,
        "wordsCount": wordsCount,
        "faTitle": faTitle,
        "title": title,
        "imagePath": imagePath,
    };
}
