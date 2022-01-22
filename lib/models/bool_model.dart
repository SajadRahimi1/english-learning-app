// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'dart:convert';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

class BookModel {
  BookModel({
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

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json["_id"],
        faTitle: json["faTitle"],
        title: json["title"],
        type: json["type"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        imagePath: json["imagePath"],
      );
}

class Item {
  Item({required this.faTitle, required this.title, required this.id});

  final String faTitle;
  final String title;
  final String id;

  factory Item.fromJson(Map<String, dynamic> json) =>
      Item(faTitle: json["faTitle"], title: json["title"], id: json['_id']);
}
