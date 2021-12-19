import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zabaner/controllers/main_screen_controller.dart';
import 'package:zabaner/views/colors.dart';
import 'package:zabaner/views/screens/book_screen.dart';
import 'package:zabaner/views/screens/client_statics_screen.dart';
import 'package:zabaner/views/screens/home_screen.dart';
import 'package:zabaner/views/screens/news_detail_screen.dart';
import 'package:zabaner/views/screens/news_screen.dart';
import 'package:zabaner/views/screens/pocast_screen.dart';
import 'package:zabaner/views/screens/profile_screen.dart';
import 'package:zabaner/views/screens/resources_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final MainScreenController _controller = Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () async {
          if (_controller
              .navigationKey[_controller.currentIndex.value].currentState!
              .canPop()) {
            _controller
                .navigationKey[_controller.currentIndex.value].currentState!
                .pop(_controller.navigationKey[_controller.currentIndex.value]
                    .currentContext);
          } else {
            // SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
          }
          return false;
        },
        child: Scaffold(
          body: SizedBox.expand(
            child: PageView(
              controller: _controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // Home screen and navigate to profile screen
                Navigator(
                  key: _controller.navigationKey[0],
                  onGenerateRoute: (settings) => MaterialPageRoute(
                    settings: settings,
                    builder: (context) {
                      switch (settings.name) {
                        case '/statics':
                          return StaticsScreen();
                        case '/profile':
                          return ProfileScreen();
                        case '/bookScreen':
                          return BookScreen();
                        case "/podcast":
                          return PodcastScreen();
                        case "/newsDetail":
                          return NewsDetailScreen();
                        case "/home":
                          return const HomeScreen();
                      }
                      return const HomeScreen();
                    },
                  ),
                ),

                // Resources screen and navigate and Book, Podcast screen
                Navigator(
                  key: _controller.navigationKey[1],
                  onGenerateRoute: (settings) => MaterialPageRoute(
                    settings: settings,
                    builder: (context) {
                      switch (settings.name) {
                        case '/bookScreen':
                          return BookScreen();
                        case '/profile':
                          return ProfileScreen();
                        case "/podcast":
                          return PodcastScreen();
                        case "/resource":
                          return const ResourcesScreen();
                      }
                      return const ResourcesScreen();
                    },
                  ),
                ),

                // News screen and navigate to news pages
                Navigator(
                  key: _controller.navigationKey[2],
                  onGenerateRoute: (settings) => MaterialPageRoute(
                    settings: settings,
                    builder: (context) {
                      if (settings.name == '/newsDetail') {
                        return NewsDetailScreen();
                      }
                      if (settings.name == '/news') {
                        return const NewsScreen();
                      }
                      if (settings.name == '/profile') {
                        return ProfileScreen();
                      }
                      return const NewsScreen();
                    },
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Obx(() => BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      _controller.currentIndex.value == 0
                          ? "assets/images/homeS.png"
                          : "assets/images/home.png",
                      width: Get.height / 6,
                      height: Get.height / 25,
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        _controller.currentIndex.value == 1
                            ? "assets/images/book_enable.png"
                            : "assets/images/book.png",
                        width: Get.height / 6,
                        height: Get.height / 25,
                      ),
                      label: "Resources"),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        _controller.currentIndex.value == 2
                            ? "assets/images/news_enable.png"
                            : "assets/images/news.png",
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
      ),
    );
  }
}
