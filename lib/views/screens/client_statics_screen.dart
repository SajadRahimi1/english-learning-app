import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/controllers/static_screen_controller.dart';
import 'package:zabaner/views/widgets/bar_chart_widget.dart';
import '../../models/level.dart';

class StaticsScreen extends StatelessWidget {
  StaticsScreen({Key? key}) : super(key: key);

  final StaticController _controller = Get.put(StaticController());
  @override
  Widget build(BuildContext context) {
    _controller.getSummaryData();
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
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/profile'),
                      child: CircleAvatar(
                        radius: Get.width / 16,
                        backgroundImage: const NetworkImage(
                            "https://randomuser.me/api/portraits/med/men/40.jpg"),
                      ),
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
                            style: TextStyle(fontFamily: "Yekan", fontSize: 18),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "آمار مطالعه منابع توسط شما",
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
                          _controller.obx((status) => Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    _controller.summaryTime.minDuration,
                                    style: const TextStyle(
                                        color: Color(0xff919191),
                                        fontFamily: "Arial",
                                        fontSize: 11),
                                  ),
                                  Text(
                                    _controller.summaryTime.maxDuration,
                                    style: const TextStyle(
                                        color: Color(0xff919191),
                                        fontFamily: "Arial",
                                        fontSize: 11),
                                  ),
                                  Text(
                                    _controller.summaryTime.avgDuration,
                                    style: const TextStyle(
                                        color: Color(0xff919191),
                                        fontFamily: "Arial",
                                        fontSize: 11),
                                  ),
                                  Text(
                                    _controller.summaryTime.sumDuration,
                                    style: const TextStyle(
                                        color: Color(0xff919191),
                                        fontFamily: "Arial",
                                        fontSize: 11),
                                  ),
                                ],
                              )),
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
                      "مدت زمان مطالعه منابع و اخبار",
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
                      horizontal: Get.height / 40, vertical: Get.height / 40),
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
                              // ============ Lines in backgorund of charts ============
                              Divider(
                                thickness: 1,
                                height: Get.height / 22,
                              ),
                              Divider(
                                thickness: 1,
                                height: Get.height / 22,
                              ),
                              Divider(
                                thickness: 1,
                                height: Get.height / 22,
                              ),
                              // =======================================================
                            ],
                          ),
                        ),
                        _controller.obx((status) => Container(
                              width: Get.width,
                              height: Get.height,
                              margin: EdgeInsets.symmetric(
                                  horizontal: Get.height / 35,
                                  vertical: Get.height / 40),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // max height is Get.height / 6.61
                                // children: [
                                //   barChart(
                                //       width: Get.width / 70,
                                //       height: Get.height / 6.5,
                                //       color: const Color(0xffFFE14D),
                                //       topText: "00:03:01",
                                //       bottomText: "امروز"),
                                //   barChart(
                                //       width: Get.width / 70,
                                //       height: Get.height / 8 / 2.5,
                                //       color: const Color(0xffAEE908),
                                //       topText: "00:02:24",
                                //       bottomText: "دیروز"),
                                //   barChart(
                                //       width: Get.width / 70,
                                //       height: Get.height / 8,
                                //       color: const Color(0xffE90827),
                                //       topText: "00:10:20",
                                //       bottomText: "00/07/01"),
                                //   barChart(
                                //       width: Get.width / 70,
                                //       height: Get.height / 8 / 1.2,
                                //       color: const Color(0xffFFA4AA),
                                //       topText: "00:07:44",
                                //       bottomText: "00/06/31"),
                                //   barChart(
                                //       width: Get.width / 70,
                                //       height: Get.height / 8 / 1.6,
                                //       color: const Color(0xffA4A7FF),
                                //       topText: "00:05:01",
                                //       bottomText: "00/06/30"),
                                // ],

                                children: List.generate(
                                  _controller.summaryTime.lastDaysStats.length,
                                  (index) => barChart(
                                      width: Get.width / 70,
                                      height: (Get.height / 6.61) *
                                          (_controller
                                                  .summaryTime
                                                  .lastDaysStats[index]
                                                  .duration
                                                  .inSeconds /
                                              _controller.sumDuration),
                                      color: const Color(0xffFFE14D),
                                      topText: _controller
                                              .summaryTime
                                              .lastDaysStats[index]
                                              .duration
                                              .inSeconds
                                              .formatSecond() +
                                          "\n ",
                                      bottomText:
                                          "${_controller.summaryTime.lastDaysStats[index].date.year}/${_controller.summaryTime.lastDaysStats[index].date.month}/${_controller.summaryTime.lastDaysStats[index].date.day}"),
                                ),
                              ),
                            ))
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
