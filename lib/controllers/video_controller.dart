import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/podcast_item_model.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/models/video_items_model.dart';
import 'package:zabaner/models/video_model.dart';
import 'package:video_player/video_player.dart';
import 'package:zabaner/views/screens/login_screen.dart';

class VideoController extends GetxController with StateMixin {
  late VideoModel videoModel;
  late VideoPlayerController videoController;
  late DateTime _dateTime;
  var playingText = "".obs;
  Rx<VideoItemsModel> videoItems = VideoItemsModel(
          id: "id",
          faTitle: "faTitle",
          title: "title",
          type: "type",
          imagePath: "imagePath",
          paragraphs: [],
          itemTitle: "itemTitle",
          itemFaTitle: "itemFaTitle",
          videoPath: "podcastPath")
      .obs;
  final GetConnect _getConnect = GetConnect();
  final GetStorage _getStorage = GetStorage();
  var isPlaying = false.obs;
  var bookmark = false.obs;
  @override
  void onInit() async {
    super.onInit();
    _getConnect.allowAutoSignedCert = true;
  }

  void customeInit() {
    _dateTime = DateTime.now();
  }

  @override
  void onClose() async {
    // TODO: implement onClose
    super.onClose();
    videoController.value.isPlaying ? () {} : videoController.pause();
    Map times = _getStorage.read('timers') ?? {};
    var lastTimer = times[
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'] ??
        0;
    if (times[
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'] ==
        null) {
      times.addAll(<String, int>{
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}':
            ((DateTime.now().difference(_dateTime).inSeconds / 3 * 2) +
                    lastTimer)
                .toInt()
      });
    } else {
      times['${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'] =
          ((DateTime.now().difference(_dateTime).inSeconds / 3 * 2) + lastTimer)
              .toInt();
    }
    if (times['totall'] == null) {
      times.addAll(<String, dynamic>{
        'totall': ((DateTime.now().difference(_dateTime).inSeconds / 3 * 2) +
                lastTimer)
            .toInt()
      });
    } else {
      var n = DateTime.now();
      print(_dateTime);
      print(n);
      var add = n.difference(_dateTime);
      print(add.inSeconds);
      times['totall'] = times['totall'] + (add.inSeconds).toInt();
    }
    await _getStorage.write('timers', times);
    // _getStorage.remove('timers');
    print(_getStorage.read('timers'));
    videoController.pause();
    videoController.removeListener(play);
  }

  void play() {
    if (videoController.value.isPlaying) {
      isPlaying.value = true;
      for (int i = 0; i < videoItems.value.paragraphs.length; i++) {
        if (videoController.value.position.inMilliseconds >
            videoItems.value.paragraphs[i].pst) {
          playingText.value = videoItems.value.paragraphs[i].en;
        }
      }
    }
  }

  void bookmarkToggle(String id) async {
    _getConnect.allowAutoSignedCert = true;

    var _request = await _getConnect.post(
        bookmarkToggleUrl, {'type': 'videos', 'bookmarkAbleId': id},
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ${_getStorage.read('token')}'
        },
        contentType: "application/json");
    print(_request.body);
    if (_request.statusCode == 201) {
      _request.body['action'] == "created"
          ? bookmark.value = true
          : bookmark.value = false;
    } else {
      Get.snackbar("Error", _request.statusText.toString());
    }
  }

  void getVideoItemData(
      String podcastId, String edposodeId, bool isGuest) async {
    _getConnect.allowAutoSignedCert = true;
    var _request = isGuest
        ? await _getConnect
            .get(getVideoDataUrl + podcastId + "/item/" + edposodeId)
        : await _getConnect.get(
            getVideoDataUrl + podcastId + "/item/" + edposodeId,
            headers: {
              'accept': 'application/json',
              'Authorization': 'Bearer ${_getStorage.read('token')}'
            },
          );

    if (_request.statusCode == 200) {
      videoItems.value = videoItemsModelFromJson(_request.bodyString ?? "");
      change(null, status: RxStatus.success());
    } else if (_request.statusCode == 401) {
      _getStorage.remove('timers');
      _getStorage.remove('token');
      _getStorage.remove('timers');
      Get.offAll(LoginScreen());
    }
    else {
      change(null, status: RxStatus.error());
    }
  }

  Future<void> getData(String id, bool isGuest) async {
    _getConnect.allowAutoSignedCert = true;

    await GetStorage.init();
    var _request = await _getConnect.get(
      getVideoDataUrl + id,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ${_getStorage.read('token')}'
      },
    );

    if (_request.statusCode == 200) {
      videoModel = videoModelFromJson(_request.bodyString ?? "");
      print(_request.body);
      videoController =
          VideoPlayerController.network(baseUrl + videoModel.items[0].videoPath)
            ..initialize().then((_) {
              change(null, status: RxStatus.success());
            });
      videoController.addListener(play);
      getVideoItemData(id, videoModel.items[0].id, isGuest);
    } else {
      change(null, status: RxStatus.error());
    }
  }
}
