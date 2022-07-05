// To parse this JSON data, do
//
//     final bookChapterModel = bookChapterModelFromJson(jsonString);

import 'dart:convert';

BookChapterModel bookChapterModelFromJson(String str) => BookChapterModel.fromJson(json.decode(str));

String bookChapterModelToJson(BookChapterModel data) => json.encode(data.toJson());

class BookChapterModel {
    BookChapterModel({
      required  this.id,
      required  this.podcastTime,
      required  this.wordsCount,
      required  this.faTitle,
      required  this.title,
      required  this.type,
      required  this.items,
      required  this.imagePath,
    });

    final String id;
    final int podcastTime;
    final int wordsCount;
    final String faTitle;
    final String title;
    final String type;
    final List<Item> items;
    final String imagePath;

    factory BookChapterModel.fromJson(Map<String, dynamic> json) => BookChapterModel(
        id: json["_id"],
        podcastTime: json["podcastTime"],
        wordsCount: json["wordsCount"],
        faTitle: json["faTitle"],
        title: json["title"],
        type: json["type"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        imagePath: json["imagePath"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "podcastTime": podcastTime,
        "wordsCount": wordsCount,
        "faTitle": faTitle,
        "title": title,
        "type": type,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "imagePath": imagePath,
    };
}

class Item {
    Item({
      required  this.podcastTime,
      required  this.wordsCount,
      required  this.faTitle,
      required  this.title,
      required  this.id,
      required  this.podcastPath,
    });

    final int podcastTime;
    final int wordsCount;
    final String faTitle;
    final String title;
    final String id;
    final String podcastPath;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        podcastTime: json["podcastTime"],
        wordsCount: json["wordsCount"],
        faTitle: json["faTitle"],
        title: json["title"],
        id: json["_id"],
        podcastPath: json["podcastPath"],
    );

    Map<String, dynamic> toJson() => {
        "podcastTime": podcastTime,
        "wordsCount": wordsCount,
        "faTitle": faTitle,
        "title": title,
        "_id": id,
        "podcastPath": podcastPath,
    };
}
