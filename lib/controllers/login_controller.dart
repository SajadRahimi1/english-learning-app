import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/screens/main_screen.dart';

class LoginController extends GetConnect {
  var error = false.obs;
  var errorMessage = "".obs;
  bool remeberLogin = false;
  Future<void> login(String username, String password) async {
    var _response =
        await post(signinUrl, {"username": username, "password": password});

    if (_response.statusCode == 201) {
      if (remeberLogin) {
        GetStorage.init();
        final GetStorage _getStorage = GetStorage();
        _getStorage.write("token", _response.body['accessToken']);
        Get.offAll(() => MainScreen());
      } else {
        Get.offAll(() => MainScreen());
      }
    }
    if (_response.statusCode == 400) {
      error.value = true;
      errorMessage.value = "نام کاربری یا رمز عبور صحیح نمی‌باشد";
    }
  }
}
