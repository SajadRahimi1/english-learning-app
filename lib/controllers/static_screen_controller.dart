import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/summary_time_static_model.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/screens/login_screen.dart';

class StaticController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  late StaticsModel summaryTime;
  final GetStorage _getStorage = GetStorage();
  int sumDuration = 0;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    await GetStorage.init();
    _getConnect.allowAutoSignedCert = true;
  }

  get getProfileImage {
    final GetStorage _getStorage = GetStorage();
    return _getStorage.read('profile_image');
  }

  void getSummaryData() async {
    _getConnect.allowAutoSignedCert = true;
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
    } else if (_request.statusCode == 401) {
      _getStorage.remove('timers');
      _getStorage.remove('token');
      _getStorage.remove('timers');
      Get.offAll(LoginScreen());
    } else {
      change(null, status: RxStatus.error());
    }
  }
}
