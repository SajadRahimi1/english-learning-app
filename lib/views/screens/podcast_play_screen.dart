import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:zabaner/controllers/play_podcast_controller.dart';
import 'package:zabaner/views/colors.dart';
import 'package:zabaner/views/widgets/text_highlight.dart';
import 'package:zabaner/models/level.dart';

class PodcastPlay extends StatefulWidget {
  PodcastPlay({Key? key, required this.isGuest, required this.id})
      : super(key: key);
  final String id;
  final bool isGuest;

  @override
  State<PodcastPlay> createState() => _PodcastPlayState();
}

class _PodcastPlayState extends State<PodcastPlay> {
  final PlayPodcastController controller = Get.put(PlayPodcastController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.customeInit();

    controller.getPodcastItemData(widget.id, widget.isGuest).then((value) {
      controller.download(controller.podcastItem.podcastPath, widget.id,
          controller.podcastItem.title);
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
    // final String id =
    //     ModalRoute.of(context)?.settings.arguments.toString() ?? "";

    return WillPopScope(
      onWillPop: () async {
        controller.onClose();
        return true;
      },
      child: SafeArea(
          child: controller.obx(
        (status) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: AppBar(
                  leading: InkWell(
                      onTap: () {
                        controller.onClose();
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back)),
                  backgroundColor: orange,
                  actions: [
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
                            child: Row(children: [
                              Icon(Icons.arrow_drop_down_sharp,
                                  color: Colors.black),
                              Icon(Icons.arrow_drop_up_sharp,
                                  color: Colors.black),
                            ]),
                          )),
                    ),
                    Row(
                      children: [
                        const Text("   انگلیسی:",
                            style:
                                TextStyle(fontFamily: "Yekan", fontSize: 16)),
                        Obx(() => Switch(
                              value: controller.en.value,
                              onChanged: (value) => controller.en.value = value,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        const Text(" فارسی:",
                            style:
                                TextStyle(fontFamily: "Yekan", fontSize: 16)),
                        Obx(() => Switch(
                              value: controller.fa.value,
                              onChanged: (value) => controller.fa.value = value,
                            ))
                      ],
                    )
                  ]),
              body: Column(children: [
                // Paragraph
                Obx(() => Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width / 25),
                        child: SizedBox(
                            width: Get.width,
                            height: Get.height,
                            child: !controller.en.value && !controller.fa.value
                                ? const SizedBox()
                                : ListView.builder(
                                    itemCount: controller
                                            .podcastItem.paragraphs.length +
                                        1,
                                    controller: controller.scrollController,
                                    itemBuilder: (context, index) => index == 0
                                        ? SizedBox(
                                            width: Get.width,
                                            child: Text(
                                              "\n" +
                                                  controller.podcastItem.title,
                                              style: const TextStyle(
                                                fontFamily: "Yekan",
                                                fontSize: 25,
                                              ),
                                              textAlign: TextAlign.center,
                                            ))
                                        : Obx(() => AutoScrollTag(
                                              index: index - 1,
                                              key: ValueKey(index - 1),
                                              controller:
                                                  controller.scrollController,
                                              child: TextHighlight(
                                                  enText: controller.podcastItem
                                                      .paragraphs[index - 1].en,
                                                  faText: controller.podcastItem
                                                      .paragraphs[index - 1].fa,
                                                  visibleEN:
                                                      controller.en.value,
                                                  visibleFA:
                                                      controller.fa.value,
                                                  enable: controller
                                                          .playingText.value ==
                                                      controller
                                                          .podcastItem
                                                          .paragraphs[index - 1]
                                                          .en),
                                            )))),
                      ),
                    )),

                Obx(() => AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: controller.isHide.value
                        ? Get.height / 9 / 1.5
                        : Get.height / 9,
                    child: Column(children: [
                      // hide or show icon
                      SizedBox(
                        height: Get.height / 30,
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
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Expanded(
                            flex: controller.isHide.value ? 1 : 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Obx(() => Text(
                                    (controller.duration.value.inSeconds -
                                            controller
                                                .playerPosition.value.inSeconds)
                                        .formatTimer())),
                                SizedBox(
                                    width: Get.width / 1.3,
                                    child: Obx(() => Slider(
                                          value: controller.playerPosition.value
                                              .inMilliseconds
                                              .toDouble(),
                                          min: 0,
                                          max: controller
                                              .duration.value.inMilliseconds
                                              .toDouble(),
                                          onChanged: (value) {
                                            controller.playerPosition.value =
                                                Duration(
                                                    milliseconds:
                                                        value.toInt());
                                          },
                                          onChangeEnd: (value) {
                                            controller.player.seekToPlayer(
                                                Duration(
                                                    milliseconds:
                                                        value.toInt()));
                                          },
                                        ))),
                                Text(controller.duration.value.inSeconds
                                    .formatTimer())
                              ],
                            )),
                      ),

                      // controll option buttons
                      controller.isHide.value
                          ? const SizedBox()
                          : Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // play speed
                                  InkWell(
                                      onTap: () {
                                        if (controller.isPlaying.value) {
                                          if (controller.playSpeed.value ==
                                              0.5) {
                                            controller.playSpeed.value = 1;
                                            controller.player.setSpeed(1);
                                          } else if (controller
                                                  .playSpeed.value ==
                                              1) {
                                            controller.playSpeed.value = 2;
                                            controller.player.setSpeed(2);
                                          } else if (controller
                                                  .playSpeed.value ==
                                              2) {
                                            controller.playSpeed.value = 0.5;
                                            controller.player.setSpeed(0.5);
                                          }
                                        }
                                      },
                                      child: Obx(() => Text(
                                            controller.playSpeed.value
                                                    .toString() +
                                                "x",
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ))),

                                  // forward
                                  InkWell(
                                      onTap: () {
                                        if (controller.ind !=
                                            controller.podcastItem.paragraphs
                                                    .length -
                                                1) {
                                          controller.player.seekToPlayer(
                                              Duration(
                                                  milliseconds: controller
                                                      .podcastItem
                                                      .paragraphs[
                                                          controller.ind + 1]
                                                      .pst));
                                        }
                                      },
                                      child: const Icon(Icons.arrow_back)),

                                  // play or pause
                                  Obx(() => InkWell(
                                      onTap: () {
                                        if (!controller.isPlaying.value) {
                                          controller.playAudio(
                                              controller.appDoc.path +
                                                  widget.id +
                                                  controller.podcastItem.title);
                                        } else {
                                          controller.player.pausePlayer();
                                          controller.isPlaying.value = false;
                                        }
                                      },
                                      child: Icon(controller.isPlaying.value
                                          ? Icons.pause
                                          : Icons.play_arrow))),

                                  // backward
                                  InkWell(
                                      onTap: () {
                                        if (controller.ind != 0) {
                                          controller.player.seekToPlayer(
                                              Duration(
                                                  milliseconds: controller
                                                      .podcastItem
                                                      .paragraphs[
                                                          controller.ind - 1]
                                                      .pst));
                                        }
                                      },
                                      child: const Icon(Icons.arrow_forward)),

                                  // repeat
                                  InkWell(
                                      onTap: () {
                                        controller.repeat.toggle();
                                      },
                                      child: Obx(() => Icon(
                                          controller.repeat.value
                                              ? Icons.repeat_one
                                              : Icons.repeat))),
                                ],
                              ),
                            )
                    ]))),
                SizedBox(
                  height: Get.height / 45,
                )
              ])),
        ),
      )),
    );
  }
}
