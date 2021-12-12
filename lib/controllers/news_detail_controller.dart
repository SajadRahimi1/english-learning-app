import 'package:get/get.dart';
import 'package:zabaner/models/news_detail_model.dart';
import 'package:zabaner/models/urls.dart';

class NewsDetailController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  late NewsDetailModel newsDetail;

  Future<void> getData(String token, String id) async {
    var _request = await _getConnect.get(newsDetailUrl + id, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (_request.statusCode == 200) {
      newsDetail = newsDetailModelFromJson(_request.bodyString ?? "");
      change(null, status: RxStatus.success());
      print(_request.body);
    } else {
      change(null, status: RxStatus.error());
    }
  }
}
