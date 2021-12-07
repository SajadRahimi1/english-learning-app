// To parse this JSON data, do
//
//     final summaryTimeSttatic = summaryTimeSttaticFromJson(jsonString);

import 'dart:convert';

SummaryTimeStatic summaryTimeSttaticFromJson(String str) =>
    SummaryTimeStatic.fromJson(json.decode(str));

class SummaryTimeStatic {
  SummaryTimeStatic({
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
  final List<dynamic> lastDaysStats;

  factory SummaryTimeStatic.fromJson(Map<String, dynamic> json) =>
      SummaryTimeStatic(
        minDuration: json["minDuration"],
        maxDuration: json["maxDuration"],
        avgDuration: json["avgDuration"],
        sumDuration: json["sumDuration"],
        lastDaysStats: List<dynamic>.from(json["lastDaysStats"].map((x) => x)),
      );
}
