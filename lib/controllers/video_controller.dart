import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/models/video_items_model.dart';
import 'package:video_player/video_player.dart';
import 'package:zabaner/views/colors.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:zabaner/views/screens/login_screen.dart';
import 'dart:io' as io;

class VideoController extends GetxController with StateMixin {
  // late VideoModel videoModel;
  late VideoPlayerController videoController;
  var isHide = false.obs;
  var videoInitialized = false.obs;
  var fa = false.obs;
  var en = false.obs;
  var repeat = false.obs;
  var duration = const Duration().obs;
  var playSpeed = 1.0.obs;
  late io.Directory appDoc;

  var downloadingPercent = 0.0.obs;

  var downloadingState = "".obs;

  var playerPosition = const Duration().obs;
  late DateTime _dateTime;
  var playingText = "".obs;
  Rx<VideoItemsModel> videoItems = VideoItemsModel(
          id: "id",
          faTitle: "faTitle",
          title: "title",
          type: "type",
          imagePath: "imagePath",
          paragraphs: [],
          videoPath: "podcastPath")
      .obs;
  final GetConnect _getConnect = GetConnect();
  final GetStorage _getStorage = GetStorage();
  var isPlaying = false.obs;
  final Dio dio = Dio();
  var playIndex = 0;
  late AutoScrollController scrollController;
  var bookmark = false.obs;
  @override
  void onInit() async {
    super.onInit();
    _getConnect.allowAutoSignedCert = true;
    scrollController = AutoScrollController();
    appDoc = await path.getApplicationDocumentsDirectory();
  }

  @override
  void dispose() async {
    super.dispose();
    onClose();
  }

  void customeInit() {
    _dateTime = DateTime.now();
    playIndex = 0;
    isPlaying = false.obs;
    isHide = false.obs;
    fa = false.obs;
    en = false.obs;
    playSpeed.value = 1;
    playIndex = 0;
    downloadingPercent = 0.0.obs;
    downloadingState = "".obs;
    repeat = false.obs;
    playingText = "".obs;
    duration = const Duration(milliseconds: 0).obs;
    playerPosition = const Duration(milliseconds: 0).obs;
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
      duration.value = videoController.value.duration;
      playerPosition.value = videoController.value.position;
      for (int i = 0; i < videoItems.value.paragraphs.length; i++) {
        if (videoController.value.position.inMilliseconds >
            videoItems.value.paragraphs[i].pst) {
          playingText.value = videoItems.value.paragraphs[i].en;
          playIndex = i;
        }
      }
      scrollController.scrollToIndex(playIndex,
          preferPosition: AutoScrollPosition.begin);
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

  void getVideoItemData(String podcastId, bool isGuest) async {
    _getConnect.allowAutoSignedCert = true;
    var _request = isGuest
        ? await _getConnect.get(getVideoDataUrl + podcastId)
        : await _getConnect.get(
            getVideoDataUrl + podcastId,
            headers: {
              'accept': 'application/json',
              'Authorization': 'Bearer ${_getStorage.read('token')}'
            },
          );

    if (_request.statusCode == 200) {
      videoItems.value = videoItemsModelFromJson(_request.bodyString ?? "");

      for (var item in videoItems.value.paragraphs) {
        if (item.fa.isNotEmpty) {
          fa.value = true;
          break;
        } else {
          fa.value = false;
        }
      }
      for (var item in videoItems.value.paragraphs) {
        if (item.en.isNotEmpty) {
          en.value = true;
          break;
        } else {
          en.value = false;
        }
      }

      if (fileExists(appDoc.path + podcastId + videoItems.value.title)) {
        videoController = VideoPlayerController.file(
            io.File(appDoc.path + podcastId + videoItems.value.title))
          ..initialize().then((_) {
            change(null, status: RxStatus.success());
            videoInitialized.value = true;
          });
        videoController.addListener(play);
      } else {
        videoController =
            VideoPlayerController.network(baseUrl + videoItems.value.videoPath)
              ..initialize().then((_) {
                change(null, status: RxStatus.success());
              });
        videoController.addListener(play);
      }

      change(null, status: RxStatus.success());
    } else if (_request.statusCode == 401) {
      _getStorage.remove('timers');
      _getStorage.remove('token');
      _getStorage.remove('timers');
      Get.offAll(LoginScreen());
    } else {
      change(null, status: RxStatus.error());
    }
  }

  void download(String urlPath, String id, String title) async {
    io.File _checkFile = io.File(appDoc.path + id + title);

    print(appDoc.path + id + title);
    if (!_checkFile.existsSync()) {
      var _downloadRequest = await dio
          .download(baseUrl + urlPath, appDoc.path + id + title,
              onReceiveProgress: (recive, total) {
        downloadingState.value = "downloading";
        downloadingPercent.value = recive / total;
        print(downloadingPercent);
      });
      Get.closeAllSnackbars();

      if (_downloadRequest.statusCode == 200) {
        print("Completed");
        Get.snackbar("", "دانلود با موفقیت به اتمام رسید",
            backgroundColor: orange);
        downloadingPercent.value = 0;
        videoController =
            VideoPlayerController.file(io.File(appDoc.path + id + title))
              ..initialize().then((_) {
                change(null, status: RxStatus.success());
                videoInitialized.value = true;
              });
        videoController.addListener(play);
      }
    } else {
      Get.snackbar(
        "",
        "شما این فایل را قبلا دانلود کرده اید",
        backgroundColor: orange,
      );
    }
  }

  bool fileExists(String path) {
    io.File _checkFile = io.File(path);
    return _checkFile.existsSync();
  }
  // Future<void> getData(String id, bool isGuest) async {
  //   _getConnect.allowAutoSignedCert = true;

  //   await GetStorage.init();
  //   var _request = await _getConnect.get(
  //     getVideoDataUrl + id,
  //     headers: {
  //       'accept': 'application/json',
  //       'Authorization': 'Bearer ${_getStorage.read('token')}'
  //     },
  //   );

  //   if (_request.statusCode == 200) {
  //     videoModel = videoModelFromJson(_request.bodyString ?? "");
  //     print(_request.body);
  //     videoController =
  //         VideoPlayerController.network(baseUrl + videoModel.items[0].videoPath)
  //           ..initialize().then((_) {
  //             change(null, status: RxStatus.success());
  //           });
  //     videoController.addListener(play);
  //     getVideoItemData(id, videoModel.items[0].id, isGuest);
  //   } else {
  //     change(null, status: RxStatus.error());
  //   }
  // }
}
