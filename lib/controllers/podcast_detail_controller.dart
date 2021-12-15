import 'package:dio/dio.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/podcast_model.dart';
import 'package:zabaner/models/urls.dart';
import 'package:path_provider/path_provider.dart' as path;

class PodcastDetailController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  late PodcastModel podcast;
  late DateTime _dateTime;
  final FlutterSoundPlayer player = FlutterSoundPlayer();
  final Dio dio = Dio();
  final GetStorage _getStorage = GetStorage();

  var isPlaying = false.obs;
  var percentPlayed = 0.0.obs;
  var downloadingPercent = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    print("Init");
    // player.isOpen() ? {} : player.openAudioSession();
    GetStorage.init();
    _dateTime = DateTime.now();
  }

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
      times.addAll({
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}':
            (DateTime.now().difference(_dateTime).inSeconds + lastTimer).toInt()
      });
    } else {
      times['${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'] =
          (DateTime.now().difference(_dateTime).inSeconds + lastTimer).toInt();
    }
    times['totall'] == null
        ? times.addAll({
            'totall':
                (DateTime.now().difference(_dateTime).inSeconds + lastTimer)
                    .toInt()
          })
        : times['totall'] = times['totall'] +
            (DateTime.now().difference(_dateTime).inSeconds).toInt();

    await _getStorage.write('timers', times);
    print(_getStorage.read('timers'));
  }

  void getPodcastData(String token, String id) async {
    var _request = await _getConnect.get(
      getPodcastDetailUrl + id,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $tokenConst'
      },
    );

    if (_request.statusCode == 200) {
      podcast = podcastModelFromJson(_request.bodyString ?? "");
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
  }

  void download(String urlPath, String id) async {
    var appDoc = await path.getApplicationDocumentsDirectory();

    var _downloadRequest = await dio.download(
        "https://zabaner-dev.herokuapp.com/podcasts/resource/podcast/temp.mp3",
        appDoc.path + id, onReceiveProgress: (recive, total) {
      downloadingPercent.value = recive / total;
      print(downloadingPercent);
    });

    if (_downloadRequest.statusCode == 200) {
      print("Completed");
    }
  }

  void playAudio(String url) async {
    // if (player.isOpen()) {
    //   await player.startPlayer(fromURI: url).then((value) {
    //     isPlaying.value = player.isPlaying;
    //   });
    //   player.setSubscriptionDuration(Duration(milliseconds: 900));
    //   player.onProgress!.listen((event) {
    //     percentPlayed.value =
    //         event.position.inMilliseconds / event.duration.inMilliseconds;
    //   });
    // }
  }
}

class DownloadPlayAudio extends GetxController with StateMixin {
  final Dio dio = Dio();

  var downloadingPercent = 0.0.obs;
}
