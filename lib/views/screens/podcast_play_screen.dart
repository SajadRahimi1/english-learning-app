import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:zabaner/controllers/play_podcast_controller.dart';
import 'package:zabaner/views/colors.dart';
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
    var en = true.obs, fa = true.obs;
    controller.getPodcastItemData(id.split(":")[0], id.split(":")[1], isGuest);
    return SafeArea(
        child: controller.obx(
      (status) => Scaffold(
          appBar: AppBar(backgroundColor: orange, actions: [
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
                      controller.download(controller.podcastItem.podcastPath,
                          id, controller.podcastItem.title);
                    },
                    child: Icon(
                      Icons.cloud_download,
                      size: Get.width / 12,
                    ),
                  )),
            Row(
              children: [
                const Text("   انگلیسی:",
                    style: TextStyle(fontFamily: "Yekan", fontSize: 16)),
                Obx(() => Switch(
                      value: en.value,
                      onChanged: (value) => en.value = value,
                    ))
              ],
            ),
            Row(
              children: [
                const Text(" فارسی:",
                    style: TextStyle(fontFamily: "Yekan", fontSize: 16)),
                Obx(() => Switch(
                      value: fa.value,
                      onChanged: (value) => fa.value = value,
                    ))
              ],
            )
          ]),
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
              child: Column(children: [
                // Paragraph
                Obx(() => SizedBox(
                    width: Get.width,
                    height: Get.height / 1.4,
                    child: !en.value && !fa.value
                        ? const SizedBox()
                        : ListView.builder(
                            itemCount: controller.podcastItem.paragraphs.length,
                            controller: controller.scrollController,
                            itemBuilder: (context, index) =>
                                Obx(() => AutoScrollTag(
                                      index: index,
                                      key: ValueKey(index),
                                      controller: controller.scrollController,
                                      child: TextHighlight(
                                          enText: controller
                                              .podcastItem.paragraphs[index].en,
                                          faText: controller
                                              .podcastItem.paragraphs[index].fa,
                                          visibleEN: en.value,
                                          visibleFA: fa.value,
                                          color: controller.playingText.value ==
                                                  controller.podcastItem
                                                      .paragraphs[index].en
                                              ? orange
                                              : Colors.white),
                                    ))))),

                // Playing audio
                InkWell(
                    onTap: () {
                      if (!controller.isPlaying.value) {
                        controller.playAudio(id.split(":")[2]);
                      } else {
                        controller.player.pausePlayer();
                        controller.isPlaying.value = false;
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
    ));
  }
}
