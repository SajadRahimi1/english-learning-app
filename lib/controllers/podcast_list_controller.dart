import 'package:get/get.dart';
import 'package:zabaner/models/book_list_model.dart';
import 'package:zabaner/models/podcast_list_model.dart';
import 'package:zabaner/models/urls.dart';

class PodcastListController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect(allowAutoSignedCert: true);

  @override
  void onInit() async {
    super.onInit();
    await getData();
  }

  late final List<PodcastListModel> model;

  Future<void> getData() async {
    final _request = await _getConnect.get(getPodcastDetailUrl);
    if (_request.statusCode == 200) {
      model = podcastListModelFromJson(_request.bodyString ?? "");
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error(""));
    }
  }
}
