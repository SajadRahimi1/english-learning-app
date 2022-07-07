// To parse this JSON data, do
//
//     final videoListModel = videoListModelFromJson(jsonString);

import 'dart:convert';

List<VideoListModel> videoListModelFromJson(String str) => List<VideoListModel>.from(json.decode(str).map((x) => VideoListModel.fromJson(x)));

String videoListModelToJson(List<VideoListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VideoListModel {
    VideoListModel({
      required  this.videoPath,
      required  this.description,
      required  this.id,
      required  this.title,
      required  this.faTitle,
      required  this.imagePath,
      required  this.podcastTime,
    });

    final String videoPath;
    final String description;
    final String id;
    final String title;
    final String faTitle;
    final String imagePath;
    final int podcastTime;

    factory VideoListModel.fromJson(Map<String, dynamic> json) => VideoListModel(
        videoPath: json["videoPath"],
        description: json["description"],
        id: json["_id"],
        title: json["title"],
        faTitle: json["faTitle"],
        imagePath: json["imagePath"],
        podcastTime: json["podcastTime"],
    );

    Map<String, dynamic> toJson() => {
        "videoPath": videoPath,
        "description": description,
        "_id": id,
        "title": title,
        "faTitle": faTitle,
        "imagePath": imagePath,
        "podcastTime": podcastTime,
    };
}
