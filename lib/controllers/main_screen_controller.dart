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

  List pages = [
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.cyan,
    ),
    Container(
      color: Colors.red,
    ),
  ];

  void tt() {}
}
