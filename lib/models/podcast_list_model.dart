// To parse this JSON data, do
//
//     final podcastListModel = podcastListModelFromJson(jsonString);

import 'dart:convert';

List<PodcastListModel> podcastListModelFromJson(String str) => List<PodcastListModel>.from(json.decode(str).map((x) => PodcastListModel.fromJson(x)));

String podcastListModelToJson(List<PodcastListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PodcastListModel {
    PodcastListModel({
      required  this.id,
      required  this.podcastTime,
      required  this.description,
      required  this.faTitle,
      required  this.title,
      required  this.imagePath,
      required  this.podcastPath,
    });

    final String id;
    final int podcastTime;
    final String description;
    final String faTitle;
    final String title;
    final String imagePath;
    final String podcastPath;

    factory PodcastListModel.fromJson(Map<String, dynamic> json) => PodcastListModel(
        id: json["_id"],
        podcastTime: json["podcastTime"],
        description: json["description"],
        faTitle: json["faTitle"],
        title: json["title"],
        imagePath: json["imagePath"],
        podcastPath: json["podcastPath"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "podcastTime": podcastTime,
        "description": description,
        "faTitle": faTitle,
        "title": title,
        "imagePath": imagePath,
        "podcastPath": podcastPath,
    };
}
