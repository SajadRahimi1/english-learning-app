import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:zabaner/controllers/video_controller.dart';
import 'package:zabaner/views/colors.dart';
import 'package:zabaner/views/widgets/text_highlight.dart';

class VideoDetailScreen extends StatelessWidget {
  VideoDetailScreen({Key? key, required this.isGuest}) : super(key: key);
  final VideoController controller = Get.put(VideoController());
  final bool isGuest;
  @override
  Widget build(BuildContext context) {
    final String id =
        ModalRoute.of(context)?.settings.arguments.toString() ?? "";

    controller.customeInit();
    controller.getData(id, isGuest);

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
              child: controller.videoController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: controller.videoController.value.aspectRatio,
                      child: VideoPlayer(controller.videoController),
                    )
                  : Container()

              // back button
              // child: Padding(
              //   padding: EdgeInsets.only(
              //     right: Get.width / 80,
              //   ),
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: IconButton(
              //       icon: const Icon(Icons.arrow_back),
              //       onPressed: () {
              //         Navigator.pop(context);
              //       },
              //     ),
              //   ),
              // ),
              ),

          // bootom of image
          SizedBox(
            width: Get.width / 1.15,
            height: Get.height / 20,
            child:
                // share and bookmark icon
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  // bookmark icon
                  InkWell(
                    onTap: () async {
                      controller.bookmarkToggle(id);
                    },
                    child: Obx(() => Icon(
                          controller.bookmark.value
                              ? Icons.bookmark
                              : Icons.bookmark_outline,
                          size: Get.width / 11,
                        )),
                  ),
                  InkWell(
                      onTap: () async {
                        if (controller.videoController.value.isPlaying) {
                          controller.videoController.pause();
                        } else {
                          controller.videoController.play();
                        }

                        controller.isPlaying.value =
                            controller.videoController.value.isPlaying;
                      },
                      child: Obx(() => Image.asset(controller.isPlaying.value
                          ? "assets/images/pause.png"
                          : "assets/images/playv.png"))),
                  // share icon
                  SizedBox(
                    width: Get.width / 14,
                    height: Get.height,
                    child: InkWell(
                      onTap: () {
                        String _text = "";
                        for (var item
                            in controller.videoItems.value.paragraphs) {
                          _text += item.en + "\n";
                          _text += item.fa + "\n";
                        }
                        Share.share(_text);
                      },
                      child: Image.asset(
                        "assets/images/share.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ]),
          ),
          Container(
            height: Get.height / 3,
            child: Obx(() => controller.videoItems.value.paragraphs.isNotEmpty
                ? ListView.builder(
                    itemCount: controller.videoItems.value.paragraphs.length,
                    itemBuilder: (context, index) => Obx(() => TextHighlight(
                        enText:
                            controller.videoItems.value.paragraphs[index].en,
                        faText:
                            controller.videoItems.value.paragraphs[index].fa,
                        color: controller.playingText.value ==
                                controller.videoItems.value.paragraphs[index].en
                            ? orange
                            : Colors.white)))
                : const SizedBox()),
          )
        ],
      ),
    )));
  }
}
