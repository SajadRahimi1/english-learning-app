import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:zabaner/controllers/video_controller.dart';
import 'package:zabaner/models/level.dart';
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
        child: WillPopScope(
      onWillPop: () async {
        controller.onClose();
        return true;
      },
      child: Scaffold(
          body: controller.obx(
        (status) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // video in top of screen
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Get.width / 50, vertical: 5),
                height: Get.height / 2.2,
                width: Get.width,
                child: controller.videoController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio:
                            controller.videoController.value.aspectRatio,
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

            // Icons
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

            // paragraphs
            Container(
              color: Colors.cyan,
              height: Get.height / 3,
              child: Obx(() => controller.videoItems.value.paragraphs.isNotEmpty
                  ? ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.videoItems.value.paragraphs.length,
                      itemBuilder: (context, index) => Obx(() => AutoScrollTag(
                            controller: controller.scrollController,
                            key: ValueKey(index),
                            index: index,
                            child: TextHighlight(
                                enText: controller
                                    .videoItems.value.paragraphs[index].en,
                                faText: controller
                                    .videoItems.value.paragraphs[index].fa,
                                color: controller.playingText.value ==
                                        controller.videoItems.value
                                            .paragraphs[index].en
                                    ? orange
                                    : Colors.white),
                          )))
                  : const SizedBox()),
            ),

            // video controller
            Obx(() => AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: controller.isHide.value
                    ? Get.height / 11 / 1.5
                    : Get.height / 11,
                child: Column(children: [
                  // hide or show icon
                  SizedBox(
                    height: Get.height / 37,
                    child: InkWell(
                      onTap: () => controller.isHide.toggle(),
                      child: Image.asset(
                        controller.isHide.value
                            ? "assets/images/upward2.png"
                            : "assets/images/downward2.png",
                        height: double.infinity,
                      ),
                    ),
                  ),

                  // seekbar
                  Expanded(
                      flex: controller.isHide.value ? 1 : 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Obx(() => Text((controller.duration.value.inSeconds -
                                  controller.playerPosition.value.inSeconds)
                              .formatTimer())),
                          SizedBox(
                              width: Get.width / 1.3,
                              child: Obx(() => Slider(
                                    value: controller
                                        .playerPosition.value.inMilliseconds
                                        .toDouble(),
                                    min: 0,
                                    max: controller
                                        .duration.value.inMilliseconds
                                        .toDouble(),
                                    onChanged: (value) {
                                      controller.playerPosition.value =
                                          Duration(milliseconds: value.toInt());
                                    },
                                    onChangeEnd: (value) {
                                      controller.videoController.seekTo(
                                          Duration(
                                              milliseconds: value.toInt()));
                                    },
                                  ))),
                          Text(
                              controller.duration.value.inSeconds.formatTimer())
                        ],
                      )),

                  // controll option buttons
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: controller.isHide.value
                        ? const SizedBox()
                        : Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // play speed
                                InkWell(
                                    onTap: () {
                                      if (controller.isPlaying.value) {
                                        if (controller.playSpeed.value == 0.5) {
                                          controller.playSpeed.value = 1;
                                          controller.videoController
                                              .setPlaybackSpeed(1);
                                        } else if (controller.playSpeed.value ==
                                            1) {
                                          controller.playSpeed.value = 2;
                                          controller.videoController
                                              .setPlaybackSpeed(2);
                                        } else if (controller.playSpeed.value ==
                                            2) {
                                          controller.playSpeed.value = 0.5;
                                          controller.videoController
                                              .setPlaybackSpeed(0.5);
                                        }
                                      }
                                    },
                                    child: Obx(() => Text(
                                          controller.playSpeed.value
                                                  .toString() +
                                              "x",
                                          style: const TextStyle(fontSize: 18),
                                        ))),

                                // forward
                                InkWell(
                                    onTap: () {
                                      if (controller.playIndex !=
                                          controller.videoItems.value.paragraphs
                                                  .length -
                                              1) {
                                        controller.videoController.seekTo(
                                            Duration(
                                                milliseconds: controller
                                                    .videoItems
                                                    .value
                                                    .paragraphs[
                                                        controller.playIndex +
                                                            1]
                                                    .pst));
                                      }
                                    },
                                    child: const Icon(Icons.arrow_back)),

                                // play or pause
                                Obx(() => InkWell(
                                    onTap: () {
                                      if (!controller.isPlaying.value) {
                                        controller.videoController.play();
                                      } else {
                                        controller.videoController.pause();
                                        controller.isPlaying.value = false;
                                      }
                                    },
                                    child: Icon(controller.isPlaying.value
                                        ? Icons.pause
                                        : Icons.play_arrow))),

                                // backward
                                InkWell(
                                    onTap: () {
                                      if (controller.playIndex != 0) {
                                        controller.videoController.seekTo(
                                            Duration(
                                                milliseconds: controller
                                                    .videoItems
                                                    .value
                                                    .paragraphs[
                                                        controller.playIndex -
                                                            1]
                                                    .pst));
                                      }
                                    },
                                    child: const Icon(Icons.arrow_forward)),

                                // repeat
                                InkWell(
                                    onTap: () {
                                      // controller.repeat.toggle();
                                    },
                                    child: Obx(() => Icon(
                                        controller.repeat.value
                                            ? Icons.repeat_one
                                            : Icons.repeat))),
                              ],
                            ),
                          ),
                  )
                ]))),

            SizedBox(
              height: Get.height / 50,
            )
          ],
        ),
      )),
    ));
  }
}
