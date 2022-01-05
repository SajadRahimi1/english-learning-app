import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/models/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController with StateMixin {
  late VideoModel videoModel;
  late VideoPlayerController videoController;
  late DateTime _dateTime;
  final GetConnect _getConnect = GetConnect();
  final GetStorage _getStorage = GetStorage();
  var bookmark = false.obs;
  @override
  void onInit() async {
    super.onInit();
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

  void bookmarkToggle(String id) async {
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

  Future<void> getData(String id) async {
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
      videoController =
          VideoPlayerController.network(baseUrl + videoModel.items[0].videoPath)
            ..initialize().then((_) {
              change(null, status: RxStatus.success());
            });
    } else {
      change(null, status: RxStatus.error());
    }
  }
}
