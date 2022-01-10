import 'dart:ui';

import 'package:flutter/src/widgets/text.dart';
import 'package:get/get.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/screens/validate_reset_password_screen.dart';

class RecoveryPasswordController extends GetConnect {
  
  Future<void> SendCode(String mobail) async {
    allowAutoSignedCert = true;
    var _request = mobail.isPhoneNumber
        ? await post(forgotPasswordUrl, {'mobile': mobail})
        : await post(forgotPasswordUrl, {'email': mobail});
    print(_request.body);
    if (_request.statusCode == 201) {
      Get.to(() => ValidateResetPasswordCode(
            recovery: true,
            phoneNumber: mobail,
          ));
    } else {
      if (_request.body['error'] == 4006) {
        Get.snackbar("", "",
            messageText: const Text(
              "ایمیل در سامانه یافت نشد",
              textAlign: TextAlign.right,
            ));
      }
      if (_request.body['error'] == 4005) {
        Get.snackbar("", "",
            messageText: const Text(
              "شماره موبایل در سامانه یافت نشد",
              textAlign: TextAlign.right,
            ));
      }
    }
  }
}
