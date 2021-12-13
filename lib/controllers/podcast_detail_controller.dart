import 'package:dio/dio.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:zabaner/models/podcast_model.dart';
import 'package:zabaner/models/urls.dart';
import 'package:path_provider/path_provider.dart' as path;

class PodcastDetailController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  late PodcastModel podcast;
  final FlutterSoundPlayer player = FlutterSoundPlayer();
  final Dio dio = Dio();
  var isPlaying = false.obs;
  var percentPlayed = 0.0.obs;
  var downloadingPercent = 0.0.obs;

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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    player.openAudioSession();
  }
}

class DownloadPlayAudio extends GetxController with StateMixin {
  final Dio dio = Dio();

  var downloadingPercent = 0.0.obs;
}
