import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:zabaner/main.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/screens/validate_reset_password_screen.dart';

class SignupController extends GetConnect {
  var error = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    allowAutoSignedCert = true;
  }

  Future<void> signup(
      String username, String password, String mobile, String? email) async {
            allowAutoSignedCert = true;

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
      switch (_response.body["error"]) {
        case 4001:
          Get.snackbar("خطا", "نام کاربری قبلا در سامانه ثبت شده است");
          break;
        case 4002:
          Get.snackbar("خطا", "شماره موبایل قبلا در سامانه ثبت شده است");

          break;
        case 4003:
          Get.snackbar("خطا", "ایمیل قبلا در سامانه ثبت شده است",);
          break;
      }
    }
  }
}
