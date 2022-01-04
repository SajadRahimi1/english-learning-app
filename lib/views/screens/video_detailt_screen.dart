import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:zabaner/controllers/news_detail_controller.dart';
import 'package:zabaner/controllers/video_controller.dart';
import 'package:zabaner/models/urls.dart';

class VideoDetailScreen extends StatelessWidget {
  VideoDetailScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String id =
        ModalRoute.of(context)?.settings.arguments.toString() ?? "";
    final VideoController _controller = Get.put(VideoController());
    _controller.getData(id);
    var isPlaying = false.obs;
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
              child: _controller.videoController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio:
                          _controller.videoController.value.aspectRatio,
                      child: VideoPlayer(_controller.videoController),
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
                  SizedBox(
                      width: Get.width / 16,
                      height: Get.height,
                      child: Image.asset(
                        "assets/images/bookmark.png",
                        fit: BoxFit.fill,
                      )),
                  InkWell(
                      onTap: () {
                        _controller.videoController.value.isPlaying
                            ? _controller.videoController.pause()
                            : _controller.videoController.play();
                        isPlaying.value =
                            _controller.videoController.value.isPlaying;
                      },
                      child: Obx(() => Image.asset(isPlaying.value
                          ? "assets/images/pause.png"
                          : "assets/images/playv.png"))),
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
          SizedBox(
            height: Get.height / 3,
            width: Get.width / 1.15,
          )
        ],
      ),
    )));
  }
}
