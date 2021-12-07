import 'package:get/get.dart';
import 'package:zabaner/models/podcast_model.dart';
import 'package:zabaner/models/urls.dart';

class PodcastDetailController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  late PodcastModel podcast;

  void getPodcastData(String token, String id) async {
    var _request = await _getConnect.get(
      getPodcastDetailUrl + id,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $tokenConst'
      },
    );

    if (_request.statusCode == 200) {
      // podcast = pod
    }
  }
}
