import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/models/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController with StateMixin {
  late VideoModel videoModel;
  late VideoPlayerController videoController;
  final GetConnect _getConnect = GetConnect();
  final GetStorage _getStorage = GetStorage();

  @override
  void onInit() async {
    super.onInit();
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
