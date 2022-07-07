import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:video_player/video_player.dart';
import 'package:zabaner/controllers/video_controller.dart';
import 'package:zabaner/models/level.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/colors.dart';
import 'package:zabaner/views/widgets/text_highlight.dart';

class VideoDetailScreen extends StatefulWidget {
  VideoDetailScreen({Key? key, required this.isGuest, required this.id})
      : super(key: key);
  final bool isGuest;
  final String id;

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  final VideoController controller = Get.put(VideoController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.customeInit();
    controller.getVideoItemData(widget.id, widget.isGuest).then((value) {
      controller.download(controller.videoItems.value.videoPath, widget.id,
          controller.videoItems.value.title);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                child: Obx(() => controller.videoInitialized.value
                    ? controller.videoController.value.isInitialized
                        ? AspectRatio(
                            aspectRatio:
                                controller.videoController.value.aspectRatio,
                            child: VideoPlayer(controller.videoController),
                          )
                        : const SizedBox()
                    : Image.network(
                        baseUrl + controller.videoItems.value.imagePath,
                      ))

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
              width: Get.width / 1.1,
              height: Get.height / 20,
              child:
                  // download and text visible icon
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Row(
                      children: [
                        // bookmark icon
                        Row(
                          children: [
                            const Text("   انگلیسی:",
                                style: TextStyle(
                                    fontFamily: "Yekan", fontSize: 16)),
                            Obx(() => Switch(
                                  value: controller.en.value,
                                  onChanged: (value) =>
                                      controller.en.value = value,
                                ))
                          ],
                        ),

                        Row(
                          children: [
                            const Text(" فارسی:",
                                style: TextStyle(
                                    fontFamily: "Yekan", fontSize: 16)),
                            Obx(() => Switch(
                                  value: controller.fa.value,
                                  onChanged: (value) =>
                                      controller.fa.value = value,
                                ))
                          ],
                        ),
                      ],
                    ),
                    // Obx(() => controller.downloadingState.value == "downloading"
                    //     ? Obx(() => CircleAvatar(
                    //           backgroundColor: Colors.transparent,
                    //           child: CircularProgressIndicator(
                    //             value: controller.downloadingPercent.value,
                    //             strokeWidth: 2,
                    //           ),
                    //         ))
                    //     :
                    //     // Download
                    //     InkWell(
                    //         onTap: () {
                    //           controller.download(
                    //               controller.videoItems.value.videoPath,
                    //               id,
                    //               controller.videoItems.value.title);
                    //         },
                    //         child: Icon(
                    //           Icons.cloud_download,
                    //           size: Get.width / 12,
                    //         ),
                    //       )),
                    InkWell(
                      onTap: () => controller.autoScroll.toggle(),
                      child: Obx(() => Container(
                            margin:
                                EdgeInsets.symmetric(vertical: Get.height / 60),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: controller.autoScroll.value
                                    ? Colors.blue
                                    : Colors.red
                                // border: Border.all(
                                // color: controller.autoScroll.value
                                //     ? Colors.black
                                //     : Colors.grey,
                                // width: 0.6)
                                ),
                            child: Row(children: const [
                              Icon(Icons.arrow_drop_down_sharp,
                                  color: Colors.black),
                              Icon(Icons.arrow_drop_up_sharp,
                                  color: Colors.black),
                            ]),
                          )),
                    ),
                  ]),
            ),

            // paragraphs
            SizedBox(
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
                                visibleEN: controller.en.value,
                                visibleFA: controller.fa.value,
                                enText: controller
                                    .videoItems.value.paragraphs[index].en,
                                faText: controller
                                    .videoItems.value.paragraphs[index].fa,
                                enable: controller.playingText.value ==
                                    controller
                                        .videoItems.value.paragraphs[index].en),
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
                                      if (controller.fileExists(controller
                                              .appDoc.path +
                                          widget.id +
                                          controller.videoItems.value.title)) {
                                        if (!controller.isPlaying.value) {
                                          controller.videoController.play();
                                        } else {
                                          controller.videoController.pause();
                                          controller.isPlaying.value = false;
                                        }
                                      } else {
                                        Get.snackbar("",
                                            "ابتدا فایل صورتی را دانلود کنید");
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
