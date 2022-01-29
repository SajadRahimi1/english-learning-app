import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/controllers/podcast_detail_controller.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/screens/podcast_play_screen.dart';

class PodcastScreen extends StatelessWidget {
  PodcastScreen({Key? key, required this.isGuest}) : super(key: key);
  final PodcastDetailController controller = Get.put(PodcastDetailController());
  final bool isGuest;
  @override
  Widget build(BuildContext context) {
    final String id =
        ModalRoute.of(context)?.settings.arguments.toString() ?? "";
    controller.getPodcastData(id, isGuest);
    final GetStorage _getStorage = GetStorage();
    GetStorage.init();
    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                backgroundColor: const Color(0xffffffff),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
                  child: Column(children: [
                    // close this screen button
                    Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          controller.player.closeAudioSession();
                          controller.onClose();
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.arrow_back,
                              size: 18,
                            ),
                            Text(" بازگشت",
                                style: TextStyle(
                                    fontFamily: "Yekan", fontSize: 14)),
                          ],
                        ),
                      ),
                    ),

                    // Top of screen
                    SizedBox(
                      height: Get.height / 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // profile image
                          InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, '/profile'),
                            child: CircleAvatar(
                              radius: Get.width / 18,
                              backgroundImage: NetworkImage(_getStorage
                                      .read('profile_image') ??
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Solid_white.svg/2048px-Solid_white.svg.png"),
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
                                  "پادکست ها",
                                  style: TextStyle(
                                      fontFamily: "Yekan", fontSize: 16),
                                ),
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

                    // Space between search text input and body
                    SizedBox(
                      height: Get.height / 30,
                    ),
                    controller.obx((state) => Expanded(
                          child: Column(
                            children: [
                              // Image and Title
                              SizedBox(
                                width: Get.width,
                                height: Get.height / 3.7,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            // Image
                                            SizedBox(
                                              width: Get.width / 12,
                                              height: Get.height / 21,
                                              child: Image.asset(
                                                "assets/images/podcast.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),

                                            // English Title
                                            SizedBox(
                                              width: Get.width / 2.5,
                                              height: Get.height / 24,
                                              child: Text(
                                                "   ${controller.podcast.title}",
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: "Yekan",
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Get.width / 2.1,
                                          child: Text(
                                            "\n" + controller.podcast.faTitle,
                                            overflow: TextOverflow.ellipsis,
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                                fontFamily: "Yekan",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: Get.width / 2.3,
                                      height: Get.height / 4,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: NetworkImage(baseUrl +
                                                  controller.podcast.imagePath),
                                              fit: BoxFit.fill)),
                                    )
                                  ],
                                ),
                              ),

                              // Episodes
                              Expanded(
                                  child: ListView.builder(
                                itemCount: controller.podcast.items.length,
                                itemBuilder: (context, index) => Container(
                                  margin: EdgeInsets.only(top: Get.height / 50),
                                  width: Get.width,
                                  height: Get.height / 18,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffDBDBDB),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: Get.height / 150,
                                        horizontal: Get.width / 18),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // play audio
                                        InkWell(
                                            child: Image.asset(
                                                "assets/images/play.png"),
                                            onTap: () {
                                              Get.to(
                                                  // context, '/playPodcast',
                                                  PodcastPlay(isGuest: isGuest),
                                                  arguments: id +
                                                      ":" +
                                                      controller.podcast
                                                          .items[index].id +
                                                      ":" +
                                                      controller.appDoc.path +
                                                      id);
                                            }),

                                        // title
                                        Text(
                                            controller
                                                .podcast.items[index].title,
                                            textDirection: TextDirection.ltr,
                                            style: const TextStyle(
                                                fontFamily: "Arial",
                                                color: Color(0xff777777)))
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ))
                  ]),
                ))));
  }
}
