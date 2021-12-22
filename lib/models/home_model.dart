// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

import 'package:zabaner/models/urls.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

class HomeModel {
  HomeModel({
    required this.user,
    required this.statistics,
    required this.histories,
  });

  final User user;
  final Statistics statistics;
  final List<History> histories;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        user: User.fromJson(json["user"]),
        statistics: Statistics.fromJson(json["statistics"]),
        histories: List<History>.from(
            json["histories"].map((x) => History.fromJson(x))),
      );
}

class History {
  History({
    required this.id,
    required this.title,
    required this.type,
    required this.imagePath,
  });

  final String id;
  final String title;
  final String type;
  final String imagePath;

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["_id"],
        title: json["title"],
        type: json["type"],
        imagePath: json["imagePath"],
      );
}

class Statistics {
  Statistics({
    required this.durationSum,
    required this.last4Days,
  });

  final String durationSum;
  final List<dynamic> last4Days;

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        durationSum: json["durationSum"],
        last4Days: List<dynamic>.from(json["last4Days"].map((x) => x)),
      );
}

class User {
  User(
      {required this.fullName,
      this.avatarPath,
      required this.currentLevelProgress,
      required this.level});

  final String fullName;
  final String? avatarPath;
  final double currentLevelProgress;
  final int level;

  factory User.fromJson(Map<String, dynamic> json) => User(
        fullName: json["fullName"],
        avatarPath: baseUrl + json["avatarPath"],
        currentLevelProgress: json["currentLevelProgress"] ?? 0,
        level: json["level"] ?? 0,
      );
}
