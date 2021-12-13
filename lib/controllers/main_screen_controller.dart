import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MainScreenController extends GetxController {
  late PageController pageController;
  var currentIndex = 0.obs;
  late void Function()? onPressed;
  var first = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
    print("Dispose");
  }
}
