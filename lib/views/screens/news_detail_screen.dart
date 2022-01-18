import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zabaner/controllers/news_detail_controller.dart';
import 'package:zabaner/models/urls.dart';

class NewsDetailScreen extends StatelessWidget {
  NewsDetailScreen({Key? key}) : super(key: key);
  final NewsDetailController controller = Get.put(NewsDetailController());
  @override
  Widget build(BuildContext context) {
    final String id =
        ModalRoute.of(context)?.settings.arguments.toString() ?? "";
    controller.getData(id);
    controller.customeInit();
    return SafeArea(
        child: Scaffold(
      body: controller.obx(
        (status) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // image in top of screen
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Get.width / 50, vertical: 5),
              height: Get.height / 2.2,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(40),
                image: DecorationImage(
                    image:
                        NetworkImage(baseUrl + controller.newsDetail.imagePath),
                    fit: BoxFit.fill),
              ),

              // back button
              child: Padding(
                padding: EdgeInsets.only(
                  right: Get.width / 80,
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                      controller.onClose();
                    },
                  ),
                ),
              ),
            ),

            // bootom of image
            SizedBox(
                width: Get.width / 1.15,
                height: Get.height / 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // share and bookmark icon
                    SizedBox(
                      width: Get.width / 6,
                      height: Get.height / 25,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // bookmark icon
                            InkWell(
                              onTap: () async {
                                await controller.bookmarkToggle(id);
                              },
                              child: Obx(() => Icon(
                                    controller.bookmark.value
                                        ? Icons.bookmark
                                        : Icons.bookmark_outline,
                                    size: Get.width / 11,
                                  )),
                            ),

                            // share icon
                            SizedBox(
                              width: Get.width / 14,
                              height: Get.height,
                              child: InkWell(
                                onTap: () async {
                                  String _text = "";
                                  for (var item
                                      in controller.newsDetail.paragraphs) {
                                    _text += item.en + "\n";
                                    _text += item.fa + "\n";
                                  }
                                  await Share.share(_text);
                                },
                                child: Image.asset(
                                  "assets/images/share.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ]),
                    ),

                    // News Text
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: const Color(0xffEBB632)),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        child: Text(
                          "News",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: Get.height / 3,
              width: Get.width / 1.15,
              child: ListView.builder(
                  itemCount: controller.newsDetail.paragraphs.length + 1,
                  itemBuilder: (context, index) => index == 0
                      ?
                      // titile text
                      Text(
                          controller.newsDetail.title,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 21),
                        )
                      : Column(
                          children: [
                            // english text
                            Text(
                              "\n" +
                                  controller
                                      .newsDetail.paragraphs[index - 1].en +
                                  "\n",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontFamily: "Arial", height: 1.5),
                            ),

                            // persian text
                            const Text(
                              // _controller.newsDetail.paragraphs[index-1].fa
                              "لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان  که لازم است،\n",
                              style: TextStyle(fontFamily: "Yekan", height: 2),
                            ),
                          ],
                        )),
            )
          ],
        ),
      ),
    ));
  }
}
