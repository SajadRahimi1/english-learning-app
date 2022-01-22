import 'package:dio/dio.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:zabaner/models/book_item_model.dart';
import 'package:zabaner/models/bool_model.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/colors.dart';
import 'dart:io' as io;
import 'package:zabaner/views/screens/login_screen.dart';

class BookController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  final GetStorage _getStorage = GetStorage();
  late BookModel bookDetail;
  late BookItemModel bookItemModel;
  final FlutterSoundPlayer player = FlutterSoundPlayer();
  AutoScrollController scrollController = AutoScrollController();
  late DateTime _dateTime;
  final Dio dio = Dio();
  late io.Directory appDoc;
  var seconds = 0;
  var isPlaying = false.obs;
  var ind = 0;
  var playingText = "".obs;
  var playSpeed = 1.0.obs;
  var isHide = false.obs;
  var percentPlayed = 0.0.obs;
  var downloadingPercent = 0.0.obs;
  var duration = const Duration().obs;
  var playerPosition = const Duration().obs;
  var repeat = false.obs;
  var downloadingState = "".obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    print("Init");
    appDoc = await path.getApplicationDocumentsDirectory();
    percentPlayed = 0.0.obs;
    downloadingPercent = 0.0.obs;
    downloadingState = "".obs;
  }

  void customeInit() {
    GetStorage.init();
    _dateTime = DateTime.now();
    isHide = false.obs;
    ind = 0;
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
    player.stopPlayer();
    isPlaying.value = false;
  }

  void getBookDetail(String bookId, bool isGuest) async {
    _getConnect.allowAutoSignedCert = true;
    var request = isGuest
        ? await _getConnect.get(getBookDetailUrl + bookId)
        : await _getConnect.get(
            getBookDetailUrl + bookId,
            headers: {
              'accept': 'application/json',
              'Authorization': 'Bearer ${_getStorage.read('token')}'
            },
          );

    if (request.statusCode == 200) {
      bookDetail = bookModelFromJson(request.bodyString ?? "");
      bookDetail.items.isNotEmpty
          ? getPodcastItemData(bookId, bookDetail.items[0].id, isGuest)
          : change(null, status: RxStatus.success());
    } else if (request.statusCode == 401) {
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
          for (int i = 0; i < bookItemModel.paragraphs.length; i++) {
            if (event.position.inMilliseconds >
                bookItemModel.paragraphs[i].pst) {
              playingText.value = bookItemModel.paragraphs[i].en;
              ind = i;
            }
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
      }
    } else {
      Get.snackbar(
        "",
        "شما این فایل را قبلا دانلود کرده اید",
        backgroundColor: orange,
      );
    }
  }

  void getPodcastItemData(
      String bookId, String edposodeId, bool isGuest) async {
    _getConnect.allowAutoSignedCert = true;
    var _request = isGuest
        ? await _getConnect
            .get(getBookDetailUrl + bookId + "/item/" + edposodeId)
        : await _getConnect.get(
            getBookDetailUrl + bookId + "/item/" + edposodeId,
            headers: {
              'accept': 'application/json',
              'Authorization': 'Bearer ${_getStorage.read('token')}'
            },
          );

    if (_request.statusCode == 200) {
      bookItemModel = bookItemModelFromJson(_request.bodyString ?? "");
      change(null, status: RxStatus.success());
      print(bookItemModel.paragraphs[0].pst);
    } else if (_request.statusCode == 401) {
      _getStorage.remove('timers');
      _getStorage.remove('token');
      _getStorage.remove('timers');
      Get.offAll(LoginScreen());
    } else {
      change(null, status: RxStatus.error());
    }
  }
}
