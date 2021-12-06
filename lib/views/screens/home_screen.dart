import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/controllers/home_data_controller.dart';
import 'package:zabaner/models/urls.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeDataController _controller = Get.put(HomeDataController());
    _controller.getData(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWFiMjdmOGY4OGEwYjEyZjUwMzBiMTUiLCJpYXQiOjE2Mzg3NzIzODksImV4cCI6MTYzODgwODM4OX0.G58g83TMQPC2-GtdparASJu9Ys9n-F8e8aXGJy4ZsnI");
    const links = [
      "https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/lrg/9780/5210/9780521013338.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/91oc6Hcx1ML.jpg",
      "https://m.media-amazon.com/images/I/51OuwYNHD2L.jpg",
      "https://kbimages1-a.akamaihd.net/3647e5c0-34ee-4340-b056-056e844cfefe/1200/1200/False/ielts-academic-module-book-1.jpg"
    ];
    return SafeArea(
      child: Scaffold(
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
                        child: CircleAvatar(
                          radius: Get.width / 13,
                          backgroundImage: const NetworkImage(
                              "https://randomuser.me/api/portraits/med/men/40.jpg"),
                        ),
                      ),

                      // Hello Text
                      SizedBox(
                        width: Get.width / 1.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "سلام ${_controller.homeModel.user.fullName}!",
                              style: const TextStyle(
                                  fontFamily: "Yekan", fontSize: 22),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              "امروز وقتشه که یه قدم بیشتر مهارت کسب کنی",
                              style: TextStyle(
                                  fontFamily: "Yekan",
                                  fontSize: 10,
                                  color: Color(0xff919191)),
                            )
                          ],
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
                                      child: const Text(
                                        "LEVEL 2",
                                        style: TextStyle(
                                            fontFamily: "Aria",
                                            fontSize: 18,
                                            color: Color(0xff707070)),
                                      ),
                                    ),

                                    // Progress Circle
                                    SizedBox(
                                      height: Get.height / 3.8,
                                      width: Get.width / 2,
                                      child: Stack(
                                        children: [
                                          Card(
                                            shape: const CircleBorder(),
                                            elevation: 3,
                                            child: SizedBox(
                                              height: Get.height,
                                              width: Get.width,
                                              child:
                                                  const CircularProgressIndicator(
                                                strokeWidth: 8,
                                                color: Color(0xffFFC200),
                                                value: 0.3,
                                              ),
                                            ),
                                          ),
                                          const Center(
                                            child: Text(
                                              "8/20",
                                              style: TextStyle(
                                                  fontFamily: "Arial",
                                                  fontSize: 15,
                                                  color: Color(0xff707070)),
                                            ),
                                          )
                                        ],
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
                                    children: [
                                      // chart circle box image
                                      Card(
                                        color: const Color(0xffffffff),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(150)),
                                        child: Container(
                                          width: Get.width / 7.3,
                                          height: Get.height / 13,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: Image.asset(
                                            "assets/images/CHART2.png",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),

                                      const Text(
                                        "MO:    2D:8H:22M ",
                                        style: TextStyle(
                                            fontFamily: "Arial",
                                            fontSize: 10,
                                            color: Color(0xff9F9F9F)),
                                      ),
                                      const Text(
                                        "Tu:      2D:8H:22M ",
                                        style: TextStyle(
                                            fontFamily: "Arial",
                                            fontSize: 10,
                                            color: Color(0xff9F9F9F)),
                                      ),
                                      const Text(
                                        "We:     2D:8H:22M ",
                                        style: TextStyle(
                                            fontFamily: "Arial",
                                            fontSize: 10,
                                            color: Color(0xff9F9F9F)),
                                      ),
                                      const Text(
                                        "Th:      2D:8H:22M ",
                                        style: TextStyle(
                                            fontFamily: "Arial",
                                            fontSize: 10,
                                            color: Color(0xff9F9F9F)),
                                      ),
                                      const Text(
                                        "Fr:       2D:8H:22M ",
                                        style: TextStyle(
                                            fontFamily: "Arial",
                                            fontSize: 10,
                                            color: Color(0xff9F9F9F)),
                                      ),
                                    ],
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
                      itemBuilder: (context, index) => Container(
                        width: Get.width / 2.6,
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            image: DecorationImage(
                                image: NetworkImage(baseUrl +
                                    _controller
                                        .homeModel.histories[index].imagePath),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(35)),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
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
