import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/views/widgets/book_resources.dart';
import 'package:zabaner/views/widgets/pocast_resources.dart';
import 'package:zabaner/views/widgets/serach_text_input.dart';
import 'package:zabaner/views/widgets/video_resources.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                backgroundColor: const Color(0xffffffff),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 40),
                  child: ListView(children: [
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

                    const SizedBox(
                      height: 30,
                    ),
                    BookResources(),
                    PocastResources(),
                    VideoResources()
                  ]),
                ))));
  }
}
