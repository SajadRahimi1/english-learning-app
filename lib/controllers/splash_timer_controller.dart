import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:zabaner/views/screens/login_screen.dart';

class SplashScreenTimer extends GetxController {
  final BuildContext context;

  SplashScreenTimer(this.context);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(milliseconds: 2900), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
      dispose();
    });
  }
}
