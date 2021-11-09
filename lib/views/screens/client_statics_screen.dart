import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaticsScreen extends StatelessWidget {
  const StaticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xffffffff),
          body: Column(
            children: [
              // close this screen button
              Padding(
                padding: EdgeInsets.only(
                  right: Get.width / 20,
                ),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.arrow_back,
                        size: 18,
                      ),
                      Text("بازگشت",
                          style: TextStyle(fontFamily: "Yekan", fontSize: 12)),
                    ],
                  ),
                ),
              ),

              // Top of screen
              Container(
                height: Get.height / 7,
                padding: EdgeInsets.symmetric(horizontal: Get.width / 40),
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
                            style: TextStyle(fontFamily: "Yekan", fontSize: 16),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "امروز وقتشه که یه قدم بیشتر مهارت کسب کنی",
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

              // Statics Yellow Container
              Expanded(
                child: Center(
                    child: Container(
                  width: Get.width / 4.3,
                  height: Get.height / 27,
                  decoration: BoxDecoration(
                      color: const Color(0xffFFC200),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("آمارها  ",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Yekan",
                              fontSize: 17)),
                      SizedBox(
                          width: Get.width / 19,
                          height: Get.height / 35,
                          child: Image.asset("assets/images/CHART.png"))
                    ],
                  ),
                )),
                flex: 1,
              ),

              // Times summry
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 15),
                child: SizedBox(
                    width: Get.width,
                    child: const Text(
                      "خلاصه زمان استفاده",
                      style: TextStyle(
                          fontFamily: "Yekan",
                          fontSize: 11,
                          color: Color(0xff686868)),
                    )),
              ),
              Expanded(
                child: Card(
                  margin: EdgeInsets.symmetric(
                      horizontal: Get.height / 40, vertical: Get.height / 30),
                  color: const Color(0xffF9F9F9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "کمترین مدت استفاده در 30 روز گذشته",
                                style: TextStyle(
                                    color: Color(0xff919191),
                                    fontFamily: "Yekan",
                                    fontSize: 11),
                              ),
                              Text(
                                "بیشترین مدت استفاده در 30 روز گذشته",
                                style: TextStyle(
                                    color: Color(0xff919191),
                                    fontFamily: "Yekan",
                                    fontSize: 11),
                              ),
                              Text(
                                "میانگین مدت استفاده در 30 روز گذشته",
                                style: TextStyle(
                                    color: Color(0xff919191),
                                    fontFamily: "Yekan",
                                    fontSize: 11),
                              ),
                              Text(
                                "مجموع مدت استفاده در 30 روز گذشته",
                                style: TextStyle(
                                    color: Color(0xff919191),
                                    fontFamily: "Yekan",
                                    fontSize: 11),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                "0h /  0m  / 0s",
                                style: TextStyle(
                                    color: Color(0xff919191),
                                    fontFamily: "Arial",
                                    fontSize: 11),
                              ),
                              Text(
                                "0h /  0m  / 0s",
                                style: TextStyle(
                                    color: Color(0xff919191),
                                    fontFamily: "Arial",
                                    fontSize: 11),
                              ),
                              Text(
                                "0h /  0m  / 0s",
                                style: TextStyle(
                                    color: Color(0xff919191),
                                    fontFamily: "Arial",
                                    fontSize: 11),
                              ),
                              Text(
                                "0h /  0m  / 0s",
                                style: TextStyle(
                                    color: Color(0xff919191),
                                    fontFamily: "Arial",
                                    fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                flex: 3,
              ),

              // Times Charts
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 15),
                child: SizedBox(
                    width: Get.width,
                    child: const Text(
                      "مدت زمان مطالعه کتاب ها و گرامر",
                      style: TextStyle(
                          fontFamily: "Yekan",
                          fontSize: 11,
                          color: Color(0xff686868)),
                    )),
              ),
              Expanded(
                child: Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(
                      horizontal: Get.height / 40, vertical: Get.height / 30),
                  color: const Color(0xffF9F9F9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(
                                // color: Colors.black,
                                thickness: 1,
                                height: Get.height / 22,
                              ),
                              Divider(
                                // color: Colors.black,
                                thickness: 1,
                                height: Get.height / 22,
                              ),
                              Divider(
                                // color: Colors.black,
                                thickness: 1,
                                height: Get.height / 22,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
