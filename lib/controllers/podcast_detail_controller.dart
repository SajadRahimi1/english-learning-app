import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:zabaner/models/podcast_model.dart';
import 'package:zabaner/models/urls.dart';

class PodcastDetailController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  late PodcastModel podcast;
  final FlutterSoundPlayer player = FlutterSoundPlayer();
  var isPlaying = false.obs;
  var percentPlayed = 0.0.obs;
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    player.openAudioSession();
  }

  void playAudio(String url) async {
    if (player.isOpen()) {
      await player.startPlayer(fromURI: url).then((value) {
        isPlaying.value = player.isPlaying;
      });
      player.setSubscriptionDuration(Duration(milliseconds: 900));
      player.onProgress!.listen((event) {
        percentPlayed.value =
            event.position.inMilliseconds / event.duration.inMilliseconds;
      });
    }
  }
}
