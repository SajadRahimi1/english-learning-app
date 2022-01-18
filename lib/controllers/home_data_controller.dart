import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/home_model.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/models/level.dart';
import 'package:zabaner/views/screens/login_screen.dart';

class HomeDataController extends GetxController with StateMixin {
  late HomeModel homeModel;
  final GetConnect _getConnect = GetConnect();
  final GetStorage _getStorage = GetStorage();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    GetStorage.init();
    _getConnect.allowAutoSignedCert = true;
  }

  Future<void> sendStatics() async {
    _getConnect.allowAutoSignedCert = true;

    if (_getStorage.read('auto_backup') != false) {
      try {
        Map<String, dynamic> times = _getStorage.read('timers') ?? {};

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
            'Authorization': 'Bearer ${_getStorage.read('token')}'
          });

          print(request.body);
        }
      } catch (e) {}
    }
  }

  void getData(bool isGuest) async {
    _getConnect.allowAutoSignedCert = true;

    if (!isGuest) {
      print(_getStorage.read('token'));
      var request = await _getConnect.get(homeDataUrl, headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ${_getStorage.read('token')}'
      });

      if (request.statusCode == 200) {
        homeModel = homeModelFromJson(request.bodyString ?? "");

        if (request.body['user']['avatarPath'] == null) {
          _getStorage.write('profile_image',
              "https://htmlcolorcodes.com/assets/images/colors/bright-blue-color-solid-background-1920x1080.png");
        } else {
          _getStorage.write('profile_image', homeModel.user.avatarPath);
        }
        change(null, status: RxStatus.success());
        if (_getStorage.read('timers') == null) {
          var timers =
              request.body['statistics']['durationSum'].toString().split(":");
          if (timers.length > 2) {
            var totall = (int.parse(timers[0]) * 24 * 3600) +
                (int.parse(timers[1]) * 3600) +
                (int.parse(timers[2]) * 60);
            _getStorage.write('timers', {'totall': totall});
          }
        }
      } else if (request.statusCode == 401) {
        _getStorage.remove('timers');
        _getStorage.remove('token');
        _getStorage.remove('timers');
        Get.offAll(LoginScreen());
      } else {
        change(null, status: RxStatus.error());
      }
    } else {
      var guestMap = {
        "user": {
          "fullName": "Guest",
          "level": 0,
          "currentLevelProgress": 0,
        },
        "statistics": {"durationSum": "0:0:0", "last4Days": []},
        "histories": []
      };
      homeModel = HomeModel(
          user: User(
              currentLevelProgress: 0,
              fullName: "Guest",
              level: 0,
              avatarPath:
                  "https://htmlcolorcodes.com/assets/images/colors/bright-blue-color-solid-background-1920x1080.png"),
          statistics: Statistics(durationSum: "0:0:0", last4Days: []),
          histories: []);
      change(null, status: RxStatus.success());
    }
  }

  get getProfileImage {
    final GetStorage _getStorage = GetStorage();
    return _getStorage.read('profile_image');
  }

  int get totallSecond {
    var statics = _getStorage.read('timers') ?? {'totall': 0};

    return statics!['totall'];
    // return 0;
  }

  Map<String, dynamic> get timersLocal {
    var statics = _getStorage.read('timers') ?? {};
    return statics;
  }
}
