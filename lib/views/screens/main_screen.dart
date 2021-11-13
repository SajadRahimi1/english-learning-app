import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/controllers/main_screen_controller.dart';
import 'package:zabaner/views/colors.dart';
import 'package:zabaner/views/screens/book_screen.dart';
import 'package:zabaner/views/screens/client_statics_screen.dart';
import 'package:zabaner/views/screens/home_screen.dart';
import 'package:zabaner/views/screens/profile_screen.dart';
import 'package:zabaner/views/screens/resources_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainScreenController _controller = Get.put(MainScreenController());
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Navigator(
                onGenerateRoute: (settings) => MaterialPageRoute(
                  settings: settings,
                  builder: (context) {
                    switch (settings.name) {
                      case '/statics':
                        return const StaticsScreen();
                      case '/profile':
                        return ProfileScreen();
                    }
                    return const HomeScreen();
                  },
                ),
              ),
              Navigator(
                onGenerateRoute: (settings) => MaterialPageRoute(
                  settings: settings,
                  builder: (context) {
                    switch (settings.name) {
                      case '/bookScreen':
                        return const BookScreen();
                    }
                    return const ResourcesScreen();
                  },
                ),
              ),
              Container(
                color: Colors.cyan,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/home.png",
                    width: Get.height / 6,
                    height: Get.height / 25,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/book.png",
                      width: Get.height / 6,
                      height: Get.height / 25,
                    ),
                    label: "Resources"),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/news.png",
                      width: Get.height / 6,
                      height: Get.height / 25,
                    ),
                    label: "News"),
              ],
              currentIndex: _controller.currentIndex.value,
              selectedItemColor: Colors.black,
              selectedLabelStyle:
                  const TextStyle(fontFamily: "Yekan", color: Colors.red),
              unselectedLabelStyle: TextStyle(
                  fontFamily: "Yekan", color: Colors.grey[300], fontSize: 14),
              backgroundColor: orange,
              onTap: (value) {
                _controller.currentIndex.value = value;
                _controller.pageController.jumpToPage(value);
              },
            )),
      ),
    );
  }
}
