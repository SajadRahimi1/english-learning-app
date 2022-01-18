import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:zabaner/models/podcast_item_model.dart';
import 'package:zabaner/models/podcast_model.dart';
import 'package:zabaner/models/urls.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:zabaner/views/screens/login_screen.dart';

class PlayPodcastController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  late PodcastModel podcast;
  late DateTime _dateTime;
  final FlutterSoundPlayer player = FlutterSoundPlayer();
  final Dio dio = Dio();
  final GetStorage _getStorage = GetStorage();
  late List<RxBool> existFile;
  late PodcastItemModel podcastItem;
  late io.Directory appDoc;
  AutoScrollController scrollController = AutoScrollController();
  var isPlaying = false.obs;
  var playingText = "".obs;
  var percentPlayed = 0.0.obs;
  var downloadingPercent = 0.0.obs;
  var downloadingState = "".obs;
  @override
  void onInit() async {
    super.onInit();
    _getConnect.allowAutoSignedCert = true;
    appDoc = await path.getApplicationDocumentsDirectory();
    GetStorage.init();
    print("Init");
    percentPlayed = 0.0.obs;
    downloadingPercent = 0.0.obs;
    downloadingState = "".obs;
    var ss = await path.getTemporaryDirectory();
    print(ss.path);
  }

  void customeInit() {
    _dateTime = DateTime.now();
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
  }

  void download(String urlPath, String id, String title) async {
    io.File _checkFile = io.File(appDoc.path + id + title);
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
        print(io.File(appDoc.path + id + title).existsSync());
        for (var i = 0; i < podcast.items.length; i++) {
          if (io.File(appDoc.path + id + title).existsSync()) {
            existFile[i].value = true;
          }
        }
      } else {
        for (var i = 0; i < podcast.items.length; i++) {
          if (io.File(appDoc.path + id + title).existsSync()) {
            existFile[i].value = true;
          }
        }
      }
    }
  }

  void getPodcastItemData(
      String podcastId, String edposodeId, bool isGuest) async {
    _getConnect.allowAutoSignedCert = true;
    var _request = isGuest
        ? await _getConnect
            .get(getPodcastDetailUrl + podcastId + "/item/" + edposodeId)
        : await _getConnect.get(
            getPodcastDetailUrl + podcastId + "/item/" + edposodeId,
            headers: {
              'accept': 'application/json',
              'Authorization': 'Bearer ${_getStorage.read('token')}'
            },
          );

    if (_request.statusCode == 200) {
      podcastItem = podcastItemModelFromJson(_request.bodyString ?? "");
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

  void playAudio(String filePath) async {
    try {
      player.isOpen() ? {} : player.openAudioSession();
      io.File audioFile = io.File(filePath);
      // if (player.isOpen()) {
      await player
          .startPlayer(fromDataBuffer: audioFile.readAsBytesSync())
          .then((value) {});
      player.setSubscriptionDuration(const Duration(milliseconds: 900));
      player.onProgress!.listen((event) {
        isPlaying.value = player.isPlaying;
        percentPlayed.value =
            event.position.inMilliseconds / event.duration.inMilliseconds;
        for (int i = 0; i < podcastItem.paragraphs.length; i++) {
          if (event.position.inMilliseconds > podcastItem.paragraphs[i].pst) {
            playingText.value = podcastItem.paragraphs[i].en;
            scrollController.scrollToIndex(i);
          }
        }
      });
    } catch (e) {
      Get.snackbar("Error", "Error in play audio");
    }
  }
}
