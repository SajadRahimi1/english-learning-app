import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:zabaner/controllers/book_detail_controller.dart';
import 'package:zabaner/models/level.dart';
import 'package:zabaner/views/colors.dart';
import 'package:zabaner/views/widgets/text_highlight.dart';

class BookScreen extends StatelessWidget {
  BookScreen({Key? key, required this.isGuest}) : super(key: key);
  final BookController controller = Get.put(BookController());
  final bool isGuest;
  @override
  Widget build(BuildContext context) {
    final String bookId = ModalRoute.of(context)?.settings.arguments as String;
    controller.getPodcastItemData(bookId, isGuest);
    // final GetStorage _getStotage = GetStorage();

    GetStorage.init();
    controller.customeInit();
    return SafeArea(
        child: controller.obx(
      (status) => Directionality(
        textDirection: TextDirection.rtl,
        child: WillPopScope(
          onWillPop: () async {
            controller.onClose();
            return true;
          },
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
                    Obx(() => controller.downloadingState.value == "downloading"
                        ? Obx(() => CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: CircularProgressIndicator(
                                value: controller.downloadingPercent.value,
                                strokeWidth: 2,
                              ),
                            ))
                        :
                        // Download
                        InkWell(
                            onTap: () {
                              controller.download(
                                  controller.bookItemModel.podcastPath,
                                  bookId,
                                  controller.bookItemModel.title);
                            },
                            child: Icon(
                              Icons.cloud_download,
                              size: Get.width / 12,
                            ),
                          )),
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
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
                    child: SizedBox(
                        width: Get.width,
                        height: Get.height,
                        child: ListView.builder(
                            itemCount:
                                controller.bookItemModel.paragraphs.length + 1,
                            controller: controller.scrollController,
                            itemBuilder: (context, index) => index == 0
                                ? SizedBox(
                                    width: Get.width,
                                    child: Text(
                                      "\n" + controller.bookItemModel.title,
                                      style: const TextStyle(
                                          fontFamily: "Yekan", fontSize: 22),
                                      textAlign: TextAlign.center,
                                    ))
                                : Obx(() => AutoScrollTag(
                                      index: index,
                                      key: ValueKey(index - 1),
                                      controller: controller.scrollController,
                                      child: TextHighlight(
                                          enText: controller.bookItemModel
                                              .paragraphs[index - 1].en,
                                          faText: controller.bookItemModel
                                              .paragraphs[index - 1].fa,
                                          visibleEN: controller.en.value,
                                          visibleFA: controller.fa.value,
                                          color: controller.playingText.value ==
                                                  controller.bookItemModel
                                                      .paragraphs[index - 1].en
                                              ? orange
                                              : Colors.white),
                                    )))),
                  ),
                ),

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
                                            controller.bookItemModel.paragraphs
                                                    .length -
                                                1) {
                                          controller.player.seekToPlayer(
                                              Duration(
                                                  milliseconds: controller
                                                      .bookItemModel
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
                                          controller.playAudio(controller
                                                  .appDoc.path +
                                              bookId +
                                              controller.bookItemModel.title);
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
                                                      .bookItemModel
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
      ),
    ));
  }
}
