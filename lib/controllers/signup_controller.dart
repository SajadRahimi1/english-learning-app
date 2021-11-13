import 'dart:convert';

import 'package:get/get.dart';
import 'package:zabaner/models/urls.dart';

class SignupController extends GetConnect {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> signup(
      String username, String password, String mobile, String? email) async {
    var response = await post(signupUrl, {
      "username": username,
      "password": password,
      "mobile": mobile,
      "email": email
    });

    response.bodyString!.isNotEmpty
        ? print(jsonDecode(response.bodyString ?? ""))
        : print("null");
  }
}
