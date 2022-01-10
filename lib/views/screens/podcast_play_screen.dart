import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/controllers/play_podcast_controller.dart';
import 'package:zabaner/views/widgets/text_highlight.dart';

class PodcastPlay extends StatelessWidget {
  PodcastPlay({Key? key, required this.isGuest}) : super(key: key);
  final PlayPodcastController controller = Get.put(PlayPodcastController());
  final bool isGuest;
  @override
  Widget build(BuildContext context) {
    final String id =
        ModalRoute.of(context)?.settings.arguments.toString() ?? "";

    final GetStorage _getStorage = GetStorage();
    GetStorage.init();
    controller.customeInit();
    controller.getPodcastItemData(id.split(":")[0], id.split(":")[1], isGuest);
    return SafeArea(
      child: Scaffold(
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
              child: Column(children: [
                // close this screen button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    controller.player.closeAudioSession();
                    controller.isPlaying.value = false;
                    controller.onClose();
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.arrow_back,
                        size: 18,
                      ),
                      Text("  بازگشت",
                          style: TextStyle(fontFamily: "Yekan", fontSize: 12)),
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
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, '/profile'),
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
                              "سلام سامان!",
                              style:
                                  TextStyle(fontFamily: "Yekan", fontSize: 16),
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

                // Paragraph
                SizedBox(
                  width: Get.width,
                  height: Get.height / 1.5,
                  child: controller.obx((state) => ListView.builder(
                      itemCount: controller.podcastItem.value.paragraphs.length,
                      itemBuilder: (context, index) => controller
                              .podcastItem.value.paragraphs.isNotEmpty
                          ? Obx(() => TextHighlight(
                              enText: controller
                                  .podcastItem.value.paragraphs[index].en,
                              faText: controller
                                  .podcastItem.value.paragraphs[index].fa,
                              color: controller.playingText.value ==
                                      controller.podcastItem.value.paragraphs[index].en
                                  ? Colors.red
                                  : Colors.white))
                          : const SizedBox())),
                ),

                // Playing audio
                InkWell(
                    onTap: () {
                      if (!controller.isPlaying.value) {
                        controller.playAudio(id.split(":")[2]);
                      } else {
                        controller.player.pause(0);
                      }
                    },
                    child: SizedBox(
                      width: Get.width / 6,
                      height: Get.height / 14,
                      child: Obx(() => Image.asset(controller.isPlaying.value
                          ? "assets/images/pause.png"
                          : "assets/images/playv.png")),
                    ))
              ]))),
    );
  }
}
