import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:zabaner/models/news_detail_model.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/colors.dart';
import 'dart:io' as io;
import 'package:zabaner/views/screens/login_screen.dart';

class NewsDetailController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect(allowAutoSignedCert: true);
  late NewsItemModel newsDetail;
  final GetStorage _getStorage = GetStorage();
  late DateTime _dateTime;
  final FlutterSoundPlayer player = FlutterSoundPlayer();
  AutoScrollController scrollController = AutoScrollController();
  final Dio dio = Dio();
  late io.Directory appDoc;
  var seconds = 0;
  var isPlaying = false.obs;
  var ind = 0;
  var en = false.obs, fa = false.obs;
  var playingText = "".obs;
  var playSpeed = 1.0.obs;
  var isHide = false.obs;
  var autoScroll = true.obs;
  var percentPlayed = 0.0.obs;
  var downloadingPercent = 0.0.obs;
  var duration = const Duration().obs;
  var playerPosition = const Duration().obs;
  var repeat = false.obs;
  var downloadingState = "".obs;
  var bookmark = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    print("Init");
    appDoc = await path.getApplicationDocumentsDirectory();
    percentPlayed = 0.0.obs;
    downloadingPercent = 0.0.obs;
    downloadingState = "".obs;
    _getConnect.allowAutoSignedCert = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    onClose();
  }

  void customeInit() async {
    await GetStorage.init();
    _dateTime = DateTime.now();
    isHide = false.obs;
    ind = 0;
    en = false.obs;
    fa = false.obs;
    playingText = "".obs;
    percentPlayed = 0.0.obs;
    downloadingPercent = 0.0.obs;
    duration = const Duration(milliseconds: 0).obs;
    playerPosition = const Duration(milliseconds: 0).obs;
    downloadingState = "".obs;
    repeat = false.obs;
    playSpeed.value = 1;
  }

  @override
  void onClose() async {
    // TODO: implement onClose
    super.onClose();

    Map times = _getStorage.read('timers') ?? {};
    var lastTimer = times[
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'] ??
        0;
    if (times[
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'] ==
        null) {
      times.addAll(<String, int>{
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}':
            (DateTime.now().difference(_dateTime).inSeconds + lastTimer).toInt()
      });
    } else {
      times['${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'] =
          (DateTime.now().difference(_dateTime).inSeconds + lastTimer).toInt();
    }
    if (times['totall'] == null) {
      times.addAll(<String, dynamic>{
        'totall':
            (DateTime.now().difference(_dateTime).inSeconds + lastTimer).toInt()
      });
    } else {
      times['totall'] = times['totall'] +
          (DateTime.now().difference(_dateTime).inSeconds).toInt();
    }
    await _getStorage.write('timers', times);
    print(_getStorage.read('timers'));
    player.stopPlayer();
    isPlaying.value = false;
  }

  Future<void> getData(String id) async {
    var _request = await _getConnect.get(newsDetailUrl + id, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer ${_getStorage.read('token')}'
    });
    print(_request.body);
    if (_request.statusCode == 200) {
      newsDetail = newsItemModelFromJson(_request.bodyString ?? "");
      for (var item in newsDetail.paragraphs) {
        if (item.fa.isNotEmpty) {
          fa.value = true;
          break;
        } else {
          fa.value = false;
        }
      }
      for (var item in newsDetail.paragraphs) {
        if (item.en.isNotEmpty) {
          en.value = true;
          break;
        } else {
          en.value = false;
        }
      }
      bookmark.value = newsDetail.bookmark;
      change(null, status: RxStatus.success());
      print(_request.body);
    } else if (_request.statusCode == 401) {
      _getStorage.remove('timers');
      _getStorage.remove('token');
      _getStorage.remove('timers');
      Get.offAll(LoginScreen());
    } else {
      change(null, status: RxStatus.error());
    }
  }

  Future<bool> bookmarkToggle(String id) async {
    var _request = await _getConnect.post(
        bookmarkToggleUrl, {'type': 'news', 'bookmarkAbleId': id},
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
      return true;
    } else {
      Get.snackbar("Error", _request.statusText.toString());
    }
    return false;
  }

  void playAudio(String filePath) async {
    try {
      player.isOpen() ? {} : player.openAudioSession();
      io.File audioFile = io.File(filePath);
      // if (player.isOpen()) {
      if (audioFile.existsSync()) {
        if (player.isPaused) {
          await player.resumePlayer();
        } else {
          await player.startPlayer(
              fromDataBuffer: audioFile.readAsBytesSync(),
              whenFinished: () {
                isPlaying.value = false;
                repeat.value ? playAudio(filePath) : {};
              });
        }

        player.setSubscriptionDuration(const Duration(milliseconds: 900));
        player.onProgress!.listen((event) {
          isPlaying.value = player.isPlaying;
          duration.value = event.duration;
          playerPosition.value = event.position;
          percentPlayed.value =
              event.position.inMilliseconds / event.duration.inMilliseconds;
          for (int i = 0; i < newsDetail.paragraphs.length; i++) {
            if (event.position.inMilliseconds > newsDetail.paragraphs[i].pst) {
              playingText.value = newsDetail.paragraphs[i].en;
              ind = i;
            }
          }
          if (autoScroll.value) {
            scrollController.scrollToIndex(
              ind + 1,
              preferPosition: AutoScrollPosition.begin,
              duration: const Duration(milliseconds: 1200),
            );
          }
        });
      } else {
        Get.snackbar("", "ابتدا فایل صورتی را دانلود کنید");
      }
    } catch (e) {
      Get.snackbar("Error", "$e");
    }
  }

  void download(String urlPath, String id, String title) async {
    io.File _checkFile = io.File(appDoc.path + id + title);
    print(appDoc.path + id + title);
    if (!_checkFile.existsSync()) {
      Get.defaultDialog(
          title: "در حال دانلود فایل صوتی",
          onWillPop: () async => downloadingPercent.value == 1 ? true : false,
          backgroundColor: orange,
          content: Obx(() => CircularProgressIndicator(
                value: downloadingPercent.value,
              )));
      var _downloadRequest = await dio
          .download(baseUrl + urlPath, appDoc.path + id + title,
              onReceiveProgress: (recive, total) {
        downloadingState.value = "downloading";
        downloadingPercent.value = recive / total;
        print(downloadingPercent);
      });

      Get.closeAllSnackbars();
      Get.back();

      if (_downloadRequest.statusCode == 200) {
        print("Completed");
        Get.snackbar("", "دانلود با موفقیت به اتمام رسید",
            backgroundColor: orange);
        downloadingPercent.value = 0;
      }
    } else {
      Get.snackbar(
        "",
        "شما این فایل را قبلا دانلود کرده اید",
        backgroundColor: orange,
      );
    }
  }
}
