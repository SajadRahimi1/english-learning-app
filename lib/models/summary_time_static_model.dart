// To parse this JSON data, do
//
//     final staticsModel = staticsModelFromJson(jsonString);
import 'level.dart';
import 'dart:convert';

StaticsModel staticsModelFromJson(String str) =>
    StaticsModel.fromJson(json.decode(str));

class StaticsModel {
  StaticsModel({
    required this.minDuration,
    required this.maxDuration,
    required this.avgDuration,
    required this.sumDuration,
    required this.lastDaysStats,
  });

  final String minDuration;
  final String maxDuration;
  final String avgDuration;
  final String sumDuration;
  final List<LastDaysStat> lastDaysStats;

  factory StaticsModel.fromJson(Map<String, dynamic> json) => StaticsModel(
        minDuration: json["minDuration"],
        maxDuration: json["maxDuration"],
        avgDuration: json["avgDuration"],
        sumDuration: json["sumDuration"],
        lastDaysStats: List<LastDaysStat>.from(
            json["lastDaysStats"].map((x) => LastDaysStat.fromJson(x))),
      );
}

class LastDaysStat {
  LastDaysStat({
    required this.duration,
    required this.date,
  });

  final Duration duration;
  final DateTime date;

  factory LastDaysStat.fromJson(Map<String, dynamic> json) => LastDaysStat(
        duration: json["duration"].toString().toDuration(),
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "date": date.toIso8601String(),
      };
}
