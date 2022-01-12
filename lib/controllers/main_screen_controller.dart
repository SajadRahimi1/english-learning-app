import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get_storage/get_storage.dart';

class MainScreenController extends GetxController {
  late PageController pageController;
  var currentIndex = 0.obs;
  final GetStorage getStorage = GetStorage();
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
            current < totall - 1 ? 'بعدی' : 'تمام'),
    stepCount: 3,
  );

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    pageController = PageController();
    await GetStorage.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
    print("Dispose");
  }
}
