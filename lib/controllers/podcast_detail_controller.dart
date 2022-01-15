import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/podcast_item_model.dart';
import 'package:zabaner/models/podcast_model.dart';
import 'package:zabaner/models/urls.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:zabaner/views/screens/login_screen.dart';

class PodcastDetailController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  late PodcastModel podcast;
  // late DateTime _dateTime;
  final FlutterSoundPlayer player = FlutterSoundPlayer();
  final Dio dio = Dio();
  final GetStorage _getStorage = GetStorage();
  late List<RxBool> existFile;
  Rx<PodcastItemModel> podcastItem = PodcastItemModel(
          id: "id",
          faTitle: "faTitle",
          title: "title",
          type: "type",
          imagePath: "imagePath",
          paragraphs: [],
          itemTitle: "itemTitle",
          itemFaTitle: "itemFaTitle",
          podcastPath: "podcastPath")
      .obs;
  late io.Directory appDoc;
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

  void getPodcastData(String id, bool isGuest) async {
    var _request = isGuest
        ? await _getConnect.get(getPodcastDetailUrl + id)
        : await _getConnect.get(
            getPodcastDetailUrl + id,
            headers: {
              'accept': 'application/json',
              'Authorization': 'Bearer ${_getStorage.read('token')}'
            },
          );

    print(_request.body);
    if (_request.statusCode == 200) {
      podcast = podcastModelFromJson(_request.bodyString ?? "");
      existFile = List.generate(podcast.items.length, (index) => RxBool(false));
      for (var i = 0; i < podcast.items.length; i++) {
        if (io.File(appDoc.path + id + podcast.items[i].title).existsSync()) {
          existFile[i].value = true;
        }
      }
      change(null, status: RxStatus.success());
      if (_getStorage.read("auto_download") ?? false) {
        for (var item in podcast.items) {
          download(item.podcastPath, id, item.title);
        }
      }
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
}
