import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/controllers/podcast_detail_controller.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/widgets/serach_text_input.dart';

class PodcastScreen extends StatelessWidget {
  PodcastScreen({Key? key}) : super(key: key);
  final PodcastDetailController _controller =
      Get.put(PodcastDetailController());
  @override
  Widget build(BuildContext context) {
    _controller.getPodcastData(
        "token", ModalRoute.of(context)?.settings.arguments.toString() ?? "");
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _controller.player.closeAudioSession();
                        _controller.isPlaying.value = false;
                      },
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
                            backgroundImage:
                                NetworkImage(_getStorage.read('profile_image')),
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

                    _controller.obx((state) => Expanded(
                          child: Column(
                            children: [
                              // Image and Title
                              SizedBox(
                                width: Get.width,
                                height: Get.height / 3.5,
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
                                            SizedBox(
                                              width: Get.width / 12,
                                              height: Get.height / 21,
                                              child: Image.asset(
                                                "assets/images/podcast.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: Get.width / 2.5,
                                                  height: Get.height / 24,
                                                  child: Text(
                                                    "   ${_controller.podcast.title}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontFamily: "Yekan",
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.width / 2.5,
                                                  height: Get.height / 24,
                                                  child: const Text(
                                                    "     Dictionary of English",
                                                    style: TextStyle(
                                                        fontFamily: "Yekan",
                                                        color:
                                                            Color(0xffC2C2C2),
                                                        fontSize: 10),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: Get.width / 2.1,
                                          child: Text(
                                            _controller.podcast.faTitle,
                                            overflow: TextOverflow.ellipsis,
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                                fontFamily: "Yekan",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: Get.height / 70),
                                          child: const Text(
                                            "اخبار جهانی امروز در پادکست بی بی سی",
                                            style: TextStyle(
                                                fontFamily: "Yekan",
                                                fontSize: 10,
                                                color: Color(0xffC2C2C2)),
                                          ),
                                        )
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
                                                  _controller
                                                      .podcast.imagePath),
                                              fit: BoxFit.fill)),
                                    )
                                  ],
                                ),
                              ),

                              // Episodes
                              Expanded(
                                  child: ListView.builder(
                                itemCount: _controller.podcast.items.length,
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
                                        // play botton
                                        Obx(() => _controller.isPlaying.value
                                            ? InkWell(
                                                onTap: () {
                                                  _controller.player
                                                      .stopPlayer();

                                                  _controller.isPlaying.value =
                                                      false;
                                                },
                                                child: CircleAvatar(
                                                  child: Obx(() =>
                                                      CircularProgressIndicator(
                                                        value: _controller
                                                            .percentPlayed
                                                            .value,
                                                        strokeWidth: 2,
                                                      )),
                                                  backgroundColor:
                                                      const Color(0xffffffff),
                                                ),
                                              )
                                            : InkWell(
                                                child: Image.asset(
                                                    "assets/images/play.png"),
                                                onTap: () {
                                                  _controller.playAudio(
                                                      baseUrl +
                                                          _controller
                                                              .podcast
                                                              .items[index]
                                                              .podcastPath);
                                                  _controller.download(
                                                      _controller
                                                          .podcast
                                                          .items[index]
                                                          .podcastPath,
                                                      _controller.podcast.id +
                                                          index.toString());
                                                })),

                                        // title
                                        Text(
                                            _controller
                                                .podcast.items[index].title,
                                            textDirection: TextDirection.ltr,
                                            style: const TextStyle(
                                                fontFamily: "Arial",
                                                color: Color(0xff777777)))
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ))
                  ]),
                ))));
  }
}
