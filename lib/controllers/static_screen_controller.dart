import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/summary_time_static_model.dart';
import 'package:zabaner/models/urls.dart';

class StaticController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  late StaticsModel summaryTime;
  final GetStorage _getStorage = GetStorage();
  int sumDuration = 0;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    GetStorage.init();
  }

  void getSummaryData() async {
    var _request = await _getConnect.get(
      summaryTimeUrl,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ${_getStorage.read('token')}'
      },
    );
    print(_request.body);
    if (_request.statusCode == 200) {
      sumDuration = 0;
      summaryTime = staticsModelFromJson(_request.bodyString ?? "");
      change(null, status: RxStatus.success());
      for (var item in summaryTime.lastDaysStats) {
        sumDuration += item.duration.inSeconds;
      }
    } else {
      change(null, status: RxStatus.error());
    }
  }
}
