import 'dart:async';

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
import 'package:zabaner/views/screens/podcast_play_screen.dart';
import 'package:zabaner/views/screens/profile_screen.dart';
import 'package:zabaner/views/screens/resources_screen.dart';
import 'package:zabaner/views/screens/video_detailt_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key, required this.isGuest, this.firstTime = false})
      : super(key: key);
  final MainScreenController _controller = Get.put(MainScreenController());

  final bool isGuest;
  final bool firstTime;
  late BookScreen bookScreen;
  late NewsDetailScreen newsDetailScreen;
  late PodcastPlay podcastScreen;
  late VideoDetailScreen videoScreen;
  bool bookScreenBool = false;
  bool newsDetailScreenBool = false;
  bool podcastScreenBool = false;
  bool videoScreenBool = false;
  @override
  Widget build(BuildContext context) {
    bool doubleTap = false;
    isGuest || firstTime
        ? {
            if (_controller.getStorage.read('tour') == null)
              Timer(const Duration(milliseconds: 500), () {
                _controller.intro.start(context);
                _controller.getStorage.write('tour', true);
              })
          }
        : () {};
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
            if (podcastScreenBool) {
              podcastScreen.controller.isClosed
                  ? () {}
                  : podcastScreen.controller.onClose();
              podcastScreenBool = false;
            }

            if (bookScreenBool) {
              bookScreen.controller.isClosed
                  ? () {}
                  : bookScreen.controller.onClose();
              bookScreenBool = false;
            }

            if (newsDetailScreenBool) {
              newsDetailScreen.controller.isClosed
                  ? () {}
                  : newsDetailScreen.controller.onClose();
              newsDetailScreenBool = false;
            }
            if (videoScreenBool) {
              videoScreen.controller.isClosed
                  ? () {}
                  : videoScreen.controller.onClose();
              videoScreenBool = false;
            }
          } else {
            if (!doubleTap) {
              doubleTap = true;
              var s = ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("برای خروج دوباره کلیک کنید"),
                duration: Duration(milliseconds: 1500),
              ));
              s.closed.then((value) => doubleTap = false);
            } else {
              SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
            }
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
                          return ProfileScreen(
                            isGuest: isGuest,
                          );
                        case '/bookScreen':
                          bookScreenBool = true;
                          return bookScreen = BookScreen(
                            isGuest: isGuest,
                          );
                        case "/podcast":
                          return PodcastScreen(
                            isGuest: isGuest,
                          );
                        case "/playPodcast":
                          podcastScreenBool = true;
                          return podcastScreen = PodcastPlay(
                            isGuest: isGuest,
                          );
                        case "/newsDetail":
                          return NewsDetailScreen(isGuest: isGuest);
                        case "/home":
                          return HomeScreen(
                            isGuest: isGuest,
                          );
                        case "/video":
                          videoScreenBool = true;
                          return videoScreen =
                              VideoDetailScreen(isGuest: isGuest);
                      }
                      return HomeScreen(
                        isGuest: isGuest,
                      );
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
                          bookScreenBool = true;
                          return bookScreen = BookScreen(
                            isGuest: isGuest,
                          );
                        case '/profile':
                          return ProfileScreen(
                            isGuest: isGuest,
                          );
                        case "/podcast":
                          return PodcastScreen(
                            isGuest: isGuest,
                          );
                        case "/playPodcast":
                          podcastScreenBool = true;
                          return podcastScreen = PodcastPlay(
                            isGuest: isGuest,
                          );

                        case "/resource":
                          return ResourcesScreen(
                            isGuest: isGuest,
                          );
                        case "/video":
                          videoScreenBool = true;
                          return videoScreen =
                              VideoDetailScreen(isGuest: isGuest);
                      }
                      return ResourcesScreen(
                        isGuest: isGuest,
                      );
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
                        newsDetailScreen = NewsDetailScreen(
                          isGuest: isGuest,
                        );
                        newsDetailScreenBool = true;
                        return newsDetailScreen;
                      }
                      if (settings.name == '/news') {
                        return NewsScreen(
                          isGuest: isGuest,
                        );
                      }
                      if (settings.name == '/profile') {
                        return ProfileScreen(
                          isGuest: isGuest,
                        );
                      }
                      return NewsScreen(
                        isGuest: isGuest,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Obx(() => BottomNavigationBar(
                selectedIconTheme: IconThemeData(color: Color(0xff000000)),
                unselectedItemColor: Color(0xff858585),
                iconSize: 30,
                items: [
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/images/homeS.png"),
                      key: _controller.intro.keys[0],
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage("assets/images/book_enable.png"),
                        key: _controller.intro.keys[1],
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage("assets/images/news_enable.png"),
                        key: _controller.intro.keys[2],
                      ),
                      label: ""),
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
