import 'dart:convert';

import 'package:get/get.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/screens/validate_reset_password_screen.dart';

class SignupController extends GetConnect {
  var error = false.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> signup(
      String username, String password, String mobile, String? email) async {
    var _response = email!.isNotEmpty
        ? await post(signupUrl, {
            "username": username,
            "password": password,
            "mobile": mobile,
            "email": email
          })
        : await post(signupUrl, {
            "username": username,
            "password": password,
            "mobile": mobile,
          });
    print(_response.body);
    if (_response.statusCode == 201) {
      Get.to(() =>
          ValidateResetPasswordCode(recovery: false, phoneNumber: mobile));
    } else {
      error.value = true;
    }
  }
}
