import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/controllers/home_data_controller.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/models/level.dart';
import 'package:intl/intl.dart';
import 'package:zabaner/views/colors.dart';
import 'package:zabaner/views/screens/book_screen.dart';
import 'package:zabaner/views/screens/news_detail_screen.dart';
import 'package:zabaner/views/screens/podcast_play_screen.dart';
import 'package:zabaner/views/screens/video_detailt_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.isGuest}) : super(key: key);
  final bool isGuest;
  @override
  Widget build(BuildContext context) {
    final HomeDataController _controller = Get.put(HomeDataController());
    _controller.getData(isGuest);
    isGuest ? {} : _controller.sendStatics();
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xffffffff),
          body: _controller.obx(
            (status) => Column(
              children: [
                // Top of screen
                Container(
                  height: Get.height / 7,
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // profile image
                      InkWell(
                          onTap: () => Navigator.pushNamed(context, '/profile'),
                          // child: CircleAvatar(
                          //     radius: Get.width / 13,
                          //     backgroundImage: NetworkImage(
                          //         _controller.homeModel.user.avatarPath)
                          //         ),
                          child: Icon(Icons.menu, size: Get.width / 8)),

                      // Hello Text
                      SizedBox(
                        width: Get.width / 1.6,
                        child: Text(
                          "سلام ${_controller.homeModel.user.fullName}!",
                          style: const TextStyle(
                              fontFamily: "Yekan", fontSize: 22),
                        ),
                      ),

                      // Logo in top left
                      Container(
                        margin: EdgeInsets.only(bottom: Get.height / 20),
                        width: Get.width / 9,
                        height: Get.height / 20,
                        child: Image.asset(
                          "assets/images/home_logo.png",
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),
                ),

                // sum of duration
                SizedBox(
                  width: Get.width / 1.22,
                  child: Text(
                    _controller.homeModel.statistics.durationSum.split(":")[0] +
                        "D" +
                        ":" +
                        _controller.homeModel.statistics.durationSum
                            .split(":")[1] +
                        "H" +
                        ":" +
                        _controller.homeModel.statistics.durationSum
                            .split(":")[2] +
                        "M",
                    style: const TextStyle(
                      color: Color(0xff5A5A5A),
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),

                // charts in middle of screen
                Expanded(
                  child: SizedBox(
                    width: Get.width,
                    child: Card(
                      margin: EdgeInsets.all(Get.width / 20),
                      color: const Color(0xffF9F9F9),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(37)),
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(context, '/statics'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Circle Level
                            SizedBox(
                                width: Get.width / 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Level text
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 8, bottom: Get.height / 100),
                                      child: Text(
                                        _controller.totallSecond.level(),
                                        style: const TextStyle(
                                            fontFamily: "Aria",
                                            fontSize: 18,
                                            color: Color(0xff707070)),
                                      ),
                                    ),

                                    SizedBox(
                                      height: Get.height / 3.8,
                                      width: Get.width / 2,
                                      child: CircularPercentIndicator(
                                        radius:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        percent: _controller.totallSecond
                                            .levelPercent(),
                                        animation: true,
                                        progressColor: orange,
                                        animationDuration: 1000,
                                        lineWidth: 6,
                                        center: Text(
                                          _controller.totallSecond
                                              .showCurrent(),
                                          style: const TextStyle(
                                              fontFamily: "Arial",
                                              fontSize: 15,
                                              color: Color(0xff707070)),
                                        ),
                                      ),
                                    )
                                  ],
                                )),

                            // Time textes
                            Padding(
                              padding: EdgeInsets.only(left: Get.width / 30),
                              child: SizedBox(
                                  width: Get.width / 3.5,
                                  height: Get.height / 3.8,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                        _controller.homeModel.statistics
                                                .last4Days.length +
                                            1,
                                        (index) => index == 0
                                            ? Card(
                                                color: const Color(0xffffffff),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            150)),
                                                child: Container(
                                                  width: Get.width / 7.3,
                                                  height: Get.height / 13,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle),
                                                  child: Image.asset(
                                                    "assets/images/CHART2.png",
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              )
                                            : Text(
                                                "${DateFormat('EEEE').format(DateTime.parse(_controller.homeModel.statistics.last4Days[index - 1]['date'])).substring(0, 2)}:    ${_controller.homeModel.statistics.last4Days[index - 1]['duration']} ",
                                                style: const TextStyle(
                                                    fontFamily: "Arial",
                                                    fontSize: 11,
                                                    color: Color(0xff9F9F9F)),
                                              ),
                                      )
                                      // // chart circle box image
                                      // Card(
                                      //   color: const Color(0xffffffff),
                                      //   shape: RoundedRectangleBorder(
                                      //       borderRadius:
                                      //           BorderRadius.circular(150)),
                                      //   child: Container(
                                      //     width: Get.width / 7.3,
                                      //     height: Get.height / 13,
                                      //     decoration: const BoxDecoration(
                                      //         shape: BoxShape.circle),
                                      //     child: Image.asset(
                                      //       "assets/images/CHART2.png",
                                      //       fit: BoxFit.contain,
                                      //     ),
                                      //   ),
                                      // ),

                                      // const Text(
                                      //   "MO:    2D:8H:22M ",
                                      //   style: TextStyle(
                                      //       fontFamily: "Arial",
                                      //       fontSize: 10,
                                      //       color: Color(0xff9F9F9F)),
                                      // ),
                                      // const Text(
                                      //   "Tu:      2D:8H:22M ",
                                      //   style: TextStyle(
                                      //       fontFamily: "Arial",
                                      //       fontSize: 10,
                                      //       color: Color(0xff9F9F9F)),
                                      // ),
                                      // const Text(
                                      //   "We:     2D:8H:22M ",
                                      //   style: TextStyle(
                                      //       fontFamily: "Arial",
                                      //       fontSize: 10,
                                      //       color: Color(0xff9F9F9F)),
                                      // ),
                                      // const Text(
                                      //   "Th:      2D:8H:22M ",
                                      //   style: TextStyle(
                                      //       fontFamily: "Arial",
                                      //       fontSize: 10,
                                      //       color: Color(0xff9F9F9F)),
                                      // ),
                                      // const Text(
                                      //   "Fr:       2D:8H:22M ",
                                      //   style: TextStyle(
                                      //       fontFamily: "Arial",
                                      //       fontSize: 10,
                                      //       color: Color(0xff9F9F9F)),
                                      // ),

                                      // ],
                                      )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  flex: 7,
                ),

                // recent article text
                SizedBox(
                    width: Get.width / 1.1,
                    child: const Text(
                      "مقاله های اخیرا دیده شده توسط شما",
                      style: TextStyle(
                          fontFamily: "Yekan",
                          fontSize: 12,
                          color: Color(0xff919191)),
                    )),

                // recent article in bottom of screen
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: Get.height / 48),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _controller.homeModel.histories.length,
                      reverse: true,
                      padding: EdgeInsets.symmetric(horizontal: Get.width / 30),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          if (_controller.homeModel.histories[index].type ==
                              "news") {
                            // Navigator.pushNamed(context, '/newsDetail',
                            //     arguments:
                            //         _controller.homeModel.histories[index].id);
                            Get.to(NewsDetailScreen(isGuest: isGuest),
                                arguments:
                                    _controller.homeModel.histories[index].id);
                          }
                          if (_controller.homeModel.histories[index].type ==
                              "podcasts") {
                            // Navigator.pushNamed(context, '/podcast',
                            //     arguments:
                            //         _controller.homeModel.histories[index].id);
                            Get.to(PodcastPlay(isGuest: isGuest),
                                arguments:
                                    _controller.homeModel.histories[index].id);
                          }
                          if (_controller.homeModel.histories[index].type ==
                              "books") {
                            // Navigator.pushNamed(context, '/bookScreen',
                            //     arguments:
                            //         _controller.homeModel.histories[index].id);
                            Get.to(BookScreen(isGuest: isGuest),
                                arguments:
                                    _controller.homeModel.histories[index].id);
                          }
                          if (_controller.homeModel.histories[index].type ==
                              "videos") {
                            // Navigator.pushNamed(context, '/video',
                            //     arguments:
                            //         _controller.homeModel.histories[index].id);
                            Get.to(VideoDetailScreen(isGuest: isGuest),
                                arguments:
                                    _controller.homeModel.histories[index].id);
                          }
                        },
                        child: Container(
                          width: Get.width / 2.6,
                          decoration: BoxDecoration(
                              color: Colors.cyan,
                              image: DecorationImage(
                                  image: NetworkImage(baseUrl +
                                      _controller.homeModel.histories[index]
                                          .imagePath),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(35)),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                        ),
                      ),
                    ),
                  ),
                  flex: 6,
                ),
              ],
            ),
          )),
    );
  }
}
