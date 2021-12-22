import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';

class MainScreenController extends GetxController {
  late PageController pageController;
  var currentIndex = 0.obs;
  late void Function()? onPressed;
  var first = 0.obs;
  late DateTime currentBackPressTime;
  List<GlobalKey<NavigatorState>> navigationKey = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  Intro intro = Intro(
      widgetBuilder: StepWidgetBuilder.useDefaultTheme(
          texts: ['Home', 'Resources', 'News'],
          buttonTextBuilder: (current, totall) =>
              current < totall - 1 ? 'Next' : 'Finish'),
      stepCount: 3);

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
