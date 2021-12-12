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
    final NewsDataController _newsDataController =
        Get.put(NewsDataController());
    final NewsSearchController _searchController =
        Get.put(NewsSearchController());
    var selectedCategory = 0.obs;
    var onSearch = false.obs;
    return SafeArea(
      child: Scaffold(
          body: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: const Color(0xffffffff),
                  body: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width / 40),
                      child: ListView(children: [
                        // close this screen button
                        Obx(
                          () => Visibility(
                              visible: onSearch.value,
                              child: InkWell(
                                  onTap: () => onSearch.value = false,
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.arrow_back,
                                        size: 18,
                                      ),
                                      Text("  بازگشت",
                                          style: TextStyle(
                                              fontFamily: "Yekan",
                                              fontSize: 12)),
                                    ],
                                  ))),
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
                                backgroundImage: NetworkImage(
                                    _newsDataController.getProfileImage),
                              ),

                              // Hello Text
                              SizedBox(
                                width: Get.width / 1.72,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "منابع زبان انگلیسی",
                                      style: TextStyle(
                                          fontFamily: "Yekan", fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "اخبار متنوع به زبان انگلیسی",
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

                        // Search Text Input
                        SizedBox(
                            width: Get.width,
                            height: Get.height / 22,
                            child: SearchTextInput(
                              onClick: () {
                                onSearch.value = true;
                              },
                              onFieldSubmitted: (text) {
                                if (text.isEmpty) {
                                  onSearch.value = false;
                                } else {
                                  _searchController.search(text);
                                }
                              },
                            )),

                        const SizedBox(
                          height: 10,
                        ),

                        // body of news screen
                        Stack(
                          children: [
                            // normal items
                            SizedBox(
                                width: Get.width,
                                height: Get.height / 1.5,
                                child: Column(
                                  children: [
                                    // Tabs
                                    Container(
                                        width: Get.width,
                                        height: Get.height / 12,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffDBDBDB),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Obx(() => ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            reverse: true,
                                            itemCount: _newsDataController
                                                .categories.length,
                                            itemBuilder: (context, index) =>
                                                Obx(() => CategoryWidget(
                                                      title: _newsDataController
                                                          .categories[index],
                                                      selected: selectedCategory
                                                              .value ==
                                                          index,
                                                      onTap: () {
                                                        selectedCategory.value =
                                                            index;
                                                        _newsDataController.getContent(
                                                            _newsDataController
                                                                    .categories[
                                                                index]);
                                                      },
                                                    ))))),
                                    SizedBox(
                                      height: Get.height / 30,
                                    ),

                                    // body of tabs
                                    Expanded(
                                      child: _newsDataController.obx(
                                          (status) => ListView.builder(
                                                itemCount: _newsDataController
                                                    .content.length,
                                                itemBuilder: (context, index) =>
                                                    NewsWidget(
                                                  title: _newsDataController
                                                      .content[index].title,
                                                  id: _newsDataController
                                                      .content[index].id,
                                                  description:
                                                      _newsDataController
                                                          .content[index]
                                                          .description,
                                                  imagePath: _newsDataController
                                                      .content[index].imagePath,
                                                  bookmark: _newsDataController
                                                      .content[index].bookmark,
                                                  // onBookmarkTap: () => newsDataController
                                                  //     .bookmarkToggle(newsDataController
                                                  //         .content[index].id),
                                                ),
                                              ),
                                          onLoading: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          onError: (message) => Center(
                                                child: Text(
                                                  message.toString(),
                                                  style: const TextStyle(
                                                      color: Color(0xffff0000),
                                                      fontFamily: "Yekan",
                                                      fontSize: 18),
                                                ),
                                              )),
                                    )
                                  ],
                                )),

                            // search items
                            Obx(() => Visibility(
                                visible: onSearch.value,
                                child: Container(
                                  height: Get.height / 1.5,
                                  width: Get.width,
                                  color: Colors.white,
                                  child: Obx(() {
                                    switch (
                                        _searchController.searchState.value) {
                                      case "success":
                                        return ListView.builder(
                                            itemCount: _searchController
                                                .searchContent.length,
                                            itemBuilder: (context, index) =>
                                                NewsWidget(
                                                  id: _searchController
                                                      .searchContent[index].id,
                                                  description: _searchController
                                                      .searchContent[index]
                                                      .description,
                                                  imagePath: _searchController
                                                      .searchContent[index]
                                                      .imagePath,
                                                  title: _searchController
                                                      .searchContent[index]
                                                      .title,
                                                  bookmark: _searchController
                                                      .searchContent[index]
                                                      .bookmark,
                                                ));
                                      case "empty":
                                        return Container(
                                          height: Get.height / 1.5,
                                          width: Get.width,
                                          color: Colors.white,
                                          child: const Center(
                                            child: Text(
                                                "نتیجه ای برای جستجوی شما یافت نشد"),
                                          ),
                                        );

                                      case "loading":
                                        return Container(
                                          height: Get.height / 1.5,
                                          width: Get.width,
                                          color: Colors.white,
                                          child: const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                    }
                                    return Container(
                                      height: Get.height / 1.5,
                                      width: Get.width,
                                      color: Colors.white,
                                    );
                                  }),
                                )))
                          ],
                        )
                      ]))))),
    );
  }
}
