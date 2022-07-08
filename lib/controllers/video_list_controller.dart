import 'package:get/get.dart';
import 'package:zabaner/models/book_list_model.dart';
import 'package:zabaner/models/podcast_list_model.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/models/video_lisst_model.dart';

class VideoListController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect(allowAutoSignedCert: true);

  @override
  void onInit() async {
    super.onInit();
    await getData();
  }

  late final List<VideoListModel> model;

  Future<void> getData() async {
    final _request = await _getConnect.get(getVideoDataUrl);
    if (_request.statusCode == 200) {
      model = videoListModelFromJson(_request.bodyString ?? "");
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error(""));
    }
  }
}
