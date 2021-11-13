import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/views/widgets/serach_text_input.dart';

class PodcastScreen extends StatelessWidget {
  const PodcastScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                backgroundColor: const Color(0xffffffff),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
                  child: Column(children: [
                    // close this screen button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.arrow_back,
                            size: 18,
                          ),
                          Text("  بازگشت",
                              style:
                                  TextStyle(fontFamily: "Yekan", fontSize: 12)),
                        ],
                      ),
                    ),

                    // Top of screen
                    SizedBox(
                      height: Get.height / 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // profile image
                          CircleAvatar(
                            radius: Get.width / 18,
                            backgroundImage: const NetworkImage(
                                "https://randomuser.me/api/portraits/med/men/40.jpg"),
                          ),

                          // Hello Text
                          SizedBox(
                            width: Get.width / 1.72,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "سلام سامان!",
                                  style: TextStyle(
                                      fontFamily: "Yekan", fontSize: 16),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "اخبار متنوع به زبان انگلیسی",
                                  style: TextStyle(
                                      fontFamily: "Yekan",
                                      fontSize: 8,
                                      color: Color(0xff919191)),
                                )
                              ],
                            ),
                          ),

                          // Logo in top left
                          Container(
                            padding: EdgeInsets.only(left: Get.width / 25),
                            width: Get.width / 5,
                            height: Get.height / 14,
                            child: Image.asset(
                              "assets/images/home_logo.png",
                              fit: BoxFit.fill,
                            ),
                          )
                        ],
                      ),
                    ),

                    // Search Text Input
                    SizedBox(
                        width: Get.width,
                        height: Get.height / 22,
                        child: const SearchTextInput()),

                    // Space between search text input and body
                    SizedBox(
                      height: Get.height / 30,
                    ),

                    // Image and Title
                    SizedBox(
                      width: Get.width,
                      height: Get.height / 3.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: Get.width / 12,
                                    height: Get.height / 21,
                                    child: Image.asset(
                                      "assets/images/podcast.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: Get.width / 2.5,
                                        height: Get.height / 24,
                                        child: const Text(
                                          "   Global News",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: "Yekan",
                                              fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width / 2.5,
                                        height: Get.height / 24,
                                        child: const Text(
                                          "     Dictionary of English",
                                          style: TextStyle(
                                              fontFamily: "Yekan",
                                              color: Color(0xffC2C2C2),
                                              fontSize: 10),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const Text(
                                "اخبار جهانی",
                                style: TextStyle(
                                    fontFamily: "Yekan",
                                    fontWeight: FontWeight.w400),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: Get.height / 70),
                                child: const Text(
                                  "اخبار جهانی امروز در پادکست بی بی سی",
                                  style: TextStyle(
                                      fontFamily: "Yekan",
                                      fontSize: 10,
                                      color: Color(0xffC2C2C2)),
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: Get.width / 2.3,
                            height: Get.height / 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: NetworkImage(
                                        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/BBC_World_News_2019.svg/1200px-BBC_World_News_2019.svg.png"),
                                    fit: BoxFit.fill)),
                          )
                        ],
                      ),
                    ),

                    // Episodes
                    Expanded(
                        child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: Get.height / 50),
                          width: Get.width,
                          height: Get.height / 18,
                          decoration: BoxDecoration(
                              color: const Color(0xffDBDBDB),
                              borderRadius: BorderRadius.circular(25)),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Get.height / 150,
                                horizontal: Get.width / 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/images/play.png"),
                                const Text("1. BBC Today Global News Podcast",
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                        fontFamily: "Arial",
                                        color: Color(0xff777777)))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: Get.height / 50),
                          width: Get.width,
                          height: Get.height / 18,
                          decoration: BoxDecoration(
                              color: const Color(0xffDBDBDB),
                              borderRadius: BorderRadius.circular(25)),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Get.height / 150,
                                horizontal: Get.width / 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/images/play.png"),
                                const Text("2. Snap Judgment Sounds With BBC",
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                        fontFamily: "Arial",
                                        color: Color(0xff777777)))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: Get.height / 50),
                          width: Get.width,
                          height: Get.height / 18,
                          decoration: BoxDecoration(
                              color: const Color(0xffDBDBDB),
                              borderRadius: BorderRadius.circular(25)),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Get.height / 150,
                                horizontal: Get.width / 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/images/play.png"),
                                const Text("3. Dare To Lead With Edvard Brown",
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                        fontFamily: "Arial",
                                        color: Color(0xff777777)))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: Get.height / 50),
                          width: Get.width,
                          height: Get.height / 18,
                          decoration: BoxDecoration(
                              color: const Color(0xffDBDBDB),
                              borderRadius: BorderRadius.circular(25)),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Get.height / 150,
                                horizontal: Get.width / 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/images/play.png"),
                                const Text("4. Last Giant Produced By Drake ",
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                        fontFamily: "Arial",
                                        color: Color(0xff777777)))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))
                  ]),
                ))));
  }
}
