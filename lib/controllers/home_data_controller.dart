import 'package:get/get.dart';
import 'package:zabaner/models/home_model.dart';
import 'package:zabaner/models/urls.dart';

class HomeDataController extends GetxController with StateMixin {
  late HomeModel homeModel;
  final GetConnect _getConnect = GetConnect();
  void getData(String token) async {
    var request = await _getConnect.get(homeDataUrl, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (request.statusCode == 200) {
      homeModel = homeModelFromJson(request.bodyString ?? "");
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
  }
}
