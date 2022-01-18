import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/level.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/screens/login_screen.dart';

class SettingToggle extends GetxController {
  final GetStorage getStorage = GetStorage();
  final GetConnect _getConnect = GetConnect();
  RxBool autoDownload = false.obs;
  RxBool saveStorage = false.obs;
  RxBool darkTheme = false.obs;
  RxBool autoBackup = false.obs;
  @override
  void onInit() async {
    super.onInit();
    await GetStorage.init();
    autoDownload.value = getStorage.read('auto_download') ?? false;
    saveStorage.value = getStorage.read('save_storage') ?? false;
    darkTheme.value = getStorage.read('dark_theme') ?? false;
    autoBackup.value = getStorage.read('auto_backup') ?? true;
  }

  Future<void> sendStatics() async {
    _getConnect.allowAutoSignedCert = true;

    if (getStorage.read('auto_backup') != false) {
      try {
        Map<String, dynamic> times = getStorage.read('timers') ?? {};

        if (times.isNotEmpty) {
          var stats = [];
          times.forEach((key, value) {
            if (key != 'totall') {
              key.split("-")[1].length >= 2
                  ? {}
                  : key =
                      "${key.split("-")[0]}-0${key.split("-")[1]}-${key.split("-")[2]}";

              key.split("-")[2].length >= 2
                  ? {}
                  : key =
                      "${key.split("-")[0]}-${key.split("-")[1]}-0${key.split("-")[2]}";
              stats.add({
                "date": key,
                "duration": (int.parse(value.toString())).toInt().formatSecond()
              });
            }
          });
          var bodyRequest = {
            "stats": stats,
            "level": totallSecond.levelNumber(),
            "currentLevelProgress": totallSecond.levelPercent() * 100
          };
          print(bodyRequest);

          var request =
              await _getConnect.post(updateStaticsUrl, bodyRequest, headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer ${getStorage.read('token')}'
          });

          if (request.statusCode == 200) {
            Get.snackbar("", "تهیه نسخه پشتیبان با موفقیت انجام شد");
          }
        }
      } catch (e) {}
    }
  }

  int get totallSecond {
    var statics = getStorage.read('timers') ?? {'totall': 0};

    return statics!['totall'];
  }

  void getData(bool isGuest) async {
    _getConnect.allowAutoSignedCert = true;

    if (!isGuest) {
      print(getStorage.read('token'));
      var request = await _getConnect.get(homeDataUrl, headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ${getStorage.read('token')}'
      });

      if (request.statusCode == 200) {
        var timers =
            request.body['statistics']['durationSum'].toString().split(":");
        if (timers.length > 2) {
          var totall = (int.parse(timers[0]) * 24 * 3600) +
              (int.parse(timers[1]) * 3600) +
              (int.parse(timers[2]) * 60);
          getStorage.write('timers', {'totall': totall});
        }
        Get.snackbar("", "بازیابی اطلاعات با موفقیت انجام شد");
      } else if (request.statusCode == 401) {
        getStorage.remove('timers');
        getStorage.remove('token');
        getStorage.remove('timers');
        Get.offAll(LoginScreen());
      } else {
        Get.snackbar("", "بازیابی اطلاعات انجام نشد");
      }
    }
  }
}
