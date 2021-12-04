// To parse this JSON data, do
//
//     final profileInformation = profileInformationFromJson(jsonString);

import 'dart:convert';

ProfileInformation profileInformationFromJson(String str) =>
    ProfileInformation.fromJson(json.decode(str));

class ProfileInformation {
  ProfileInformation({
    required this.email,
    required this.mobile,
    required this.firstName,
    required this.lastName,
    required this.avatarPath,
    required this.bDay,
    required this.username,
    required this.registerMethod,
  });

  final String email;
  final String mobile;
  final String firstName;
  final String lastName;
  final String avatarPath;
  final DateTime bDay;
  final String username;
  final String registerMethod;

  factory ProfileInformation.fromJson(Map<String, dynamic> json) =>
      ProfileInformation(
        email: json["email"] ?? "",
        mobile: json["mobile"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        avatarPath: json["avatarPath"] ?? "",
        bDay: DateTime.parse(json["bDay"] ?? "2020-07-10 15:00:00.000"),
        username: json["username"] ?? "",
        registerMethod: json["registerMethod"] ?? "",
      );
}
