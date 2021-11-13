import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/views/widgets/serach_text_input.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                backgroundColor: const Color(0xffffffff),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
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

                    // Space between search text input and body
                    SizedBox(
                      height: Get.height / 30,
                    ),

                    SizedBox(
                      width: Get.width,
                      height: Get.height / 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: Get.width / 10,
                                    height: Get.height / 22,
                                    child: Image.asset(
                                      "assets/images/bookr.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: Get.width / 2,
                                        height: Get.height / 22,
                                        child: const Text(
                                          "   Oxford Dictionary",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: "Yekan",
                                              fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width / 2,
                                        height: Get.height / 22,
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
                                "دیکشنری اکسفورد",
                                style: TextStyle(
                                    fontFamily: "Yekan",
                                    fontWeight: FontWeight.w400),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: Get.height / 50),
                                child: Text(
                                  "راهنمای مبتدیان جهت مکالمات روزانه",
                                  style: TextStyle(
                                      fontFamily: "Yekan",
                                      fontSize: 10,
                                      color: Color(0xffC2C2C2)),
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: Get.width / 3.2,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: const DecorationImage(
                                    image: NetworkImage(
                                        "https://images-na.ssl-images-amazon.com/images/I/51VDi1DSQjL._SX378_BO1,204,203,200_.jpg"),
                                    fit: BoxFit.fill)),
                          )
                        ],
                      ),
                    )
                  ]),
                ))));
  }
}
