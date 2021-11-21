import 'package:flutter/material.dart';
import 'package:zabaner/controllers/news_data_controller.dart';
import 'package:zabaner/views/widgets/news_category_widget.dart';
import 'package:zabaner/views/widgets/news_widget.dart';
import 'package:zabaner/views/widgets/serach_text_input.dart';
import 'package:get/get.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewsDataController newsDataController = Get.put(NewsDataController());
    var selectedCategory = 0.obs;
    return SafeArea(
      child: Scaffold(
          body: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                  backgroundColor: const Color(0xffffffff),
                  body: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width / 40),
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
                                  style: TextStyle(
                                      fontFamily: "Yekan", fontSize: 12)),
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
                          height: 10,
                        ),

                        // Tabs
                        Container(
                            width: Get.width,
                            height: Get.height / 12,
                            decoration: BoxDecoration(
                                color: const Color(0xffDBDBDB),
                                borderRadius: BorderRadius.circular(15)),
                            child: Obx(() => ListView.builder(
                                scrollDirection: Axis.horizontal,
                                reverse: true,
                                itemCount: newsDataController.categories.length,
                                itemBuilder: (context, index) =>
                                    Obx(() => CategoryWidget(
                                          title: newsDataController
                                              .categories[index],
                                          selected:
                                              selectedCategory.value == index,
                                          onTap: () {
                                            selectedCategory.value = index;
                                            newsDataController.getContent(
                                                newsDataController
                                                    .categories[index]);
                                          },
                                        ))))),
                        SizedBox(
                          height: Get.height / 30,
                        ),

                        // body of tabs
                        Expanded(
                          child: Obx(() => ListView.builder(
                                itemCount: newsDataController.content.length,
                                itemBuilder: (context, index) => NewsWidget(
                                  title:
                                      newsDataController.content[index].title,
                                  description: newsDataController
                                      .content[index].description,
                                ),
                              )),
                        )
                      ]))))),
    );
  }
}
