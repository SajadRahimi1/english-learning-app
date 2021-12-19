import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/controllers/resources_controller.dart';
import 'package:zabaner/views/widgets/book_resources.dart';
import 'package:zabaner/views/widgets/pocast_resources.dart';
import 'package:zabaner/views/widgets/resources_search_widget.dart';
import 'package:zabaner/views/widgets/serach_text_input.dart';
import 'package:zabaner/views/widgets/video_resources.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var onSearchClick = false.obs;
    final ResourcesController _controller = Get.put(ResourcesController());
    final ResourcesSearch _searchController = Get.put(ResourcesSearch());
    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                backgroundColor: const Color(0xffffffff),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 40),
                  child: ListView(children: [
                    // Top of screen
                    SizedBox(
                      height: Get.height / 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // profile image
                          InkWell(
                            onTap: ()=>Navigator.pushNamed(context, '/profile'),
                            child: CircleAvatar(
                              radius: Get.width / 18,
                              backgroundImage:
                                  NetworkImage(_controller.getProfileImage),
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
                        onClick: () => onSearchClick.value = true,
                        onFieldSubmitted: (value) => value.isEmpty
                            ? onSearchClick.value = false
                            : {_searchController.search(value)},
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    Stack(
                      children: [
                        // Resources
                        SizedBox(
                          height: Get.height,
                          width: Get.width,
                          child: _controller.obx((state) => Column(
                                children: [
                                  BookResources(
                                    resource:
                                        _controller.resourcesList[0].resources,
                                  ),
                                  PocastResources(
                                      resource: _controller
                                          .resourcesList[1].resources),
                                  VideoResources(
                                      resource: _controller
                                          .resourcesList[2].resources)
                                ],
                              )),
                        ),

                        /// search items
                        Obx(() => Visibility(
                            visible: onSearchClick.value,
                            child: Container(
                              height: Get.height / 1.45,
                              width: Get.width,
                              color: Colors.white,
                              child: Obx(() {
                                switch (_searchController.searchState.value) {
                                  case "success":
                                    return ListView.builder(
                                        itemCount: _searchController
                                            .searchContent.length,
                                        itemBuilder: (context, index) =>
                                            ResourcesSearchWidget(
                                              id: _searchController
                                                  .searchContent[index].id,
                                              imagePath: _searchController
                                                  .searchContent[index]
                                                  .imagePath,
                                              title: _searchController
                                                  .searchContent[index].title,
                                              type: _searchController
                                                  .searchContent[index].type,
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
                                          child: CircularProgressIndicator()),
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
                  ]),
                ))));
  }
}
