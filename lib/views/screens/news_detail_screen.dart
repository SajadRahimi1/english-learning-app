import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/controllers/news_detail_controller.dart';
import 'package:zabaner/models/urls.dart';

class NewsDetailScreen extends StatelessWidget {
  NewsDetailScreen({Key? key}) : super(key: key);
  final NewsDetailController _controller = Get.put(NewsDetailController());
  @override
  Widget build(BuildContext context) {
    _controller.getData(tokenConst,
        ModalRoute.of(context)?.settings.arguments.toString() ?? "");
    return SafeArea(
        child: Scaffold(
      body: _controller.obx(
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
                    image: NetworkImage(
                        baseUrl + _controller.newsDetail.imagePath),
                    fit: BoxFit.fill),
              ),
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
                            SizedBox(
                                width: Get.width / 16,
                                height: Get.height,
                                child: Image.asset(
                                  "assets/images/bookmark.png",
                                  fit: BoxFit.fill,
                                )),
                            // share icon
                            SizedBox(
                              width: Get.width / 14,
                              height: Get.height,
                              child: Image.asset(
                                "assets/images/share.png",
                                fit: BoxFit.fill,
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
                  itemCount: _controller.newsDetail.paragraphs.length + 1,
                  itemBuilder: (context, index) => index == 0
                      ?
                      // titile text
                      Text(
                          _controller.newsDetail.title,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 21),
                        )
                      : Column(
                          children: [
                            // english text
                            Text(
                              "\n" +
                                  _controller
                                      .newsDetail.paragraphs[index - 1].en +
                                  "\n",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontFamily: "Arial", height: 1.5),
                            ),

                            // persian text
                            const Text(
                              // _controller.newsDetail.paragraphs[index-1].fa
                              "لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان  که لازم است،" +
                                  "\n",
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
