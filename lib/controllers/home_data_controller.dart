import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/home_model.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/models/level.dart';

class HomeDataController extends GetxController with StateMixin {
  late HomeModel homeModel;
  final GetConnect _getConnect = GetConnect();
  final GetStorage _getStorage = GetStorage();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    GetStorage.init();
  }

  Future<void> sendStatics() async {
    if (_getStorage.read('auto_backup') == true) {
      try {
        Map<String, dynamic> times = _getStorage.read('timers') ?? {};

        if (times.isNotEmpty) {
          var stats = [];
          times.forEach((key, value) {
            if (key != 'totall') {
              stats.add({
                "date": key,
                "duration": ((int.parse(value.toString()) / 3) * 2)
                    .toInt()
                    .formatSecond()
              });
            }
          });
          var bodyRequest = {
            "stats": stats,
            "level": totallSecond.levelNumber(),
            "currentLevelProgress": totallSecond.levelPercent() * 100
          };

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
    if (!isGuest) {
      print(_getStorage.read('token'));
      var request = await _getConnect.get(homeDataUrl, headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ${_getStorage.read('token')}'
      });

      if (request.statusCode == 200) {
        homeModel = homeModelFromJson(request.bodyString ?? "");
        // _getStorage.write('profile_image', homeModel.user.avatarPath);
        // _getStorage.write('profile_image',
        //     "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Disc_Plain_cyan.svg/1200px-Disc_Plain_cyan.svg.png");

        if (request.body['user']['avatarPath'] == null) {
          _getStorage.write('profile_image',
              "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Disc_Plain_cyan.svg/1200px-Disc_Plain_cyan.svg.png");
        } else {
          _getStorage.write('profile_image', homeModel.user.avatarPath);
        }
        change(null, status: RxStatus.success());
        if (_getStorage.read('timers') == null) {
          var timers =
              request.body['statistics']['durationSum'].toString().split(":");
          if (timers.length > 2) {
            // var totall = Duration(
            //         days: int.parse(timers[0]),
            //         hours: int.parse(timers[1]),
            //         minutes: int.parse(timers[2]))
            //     .inSeconds;
            var totall = (int.parse(timers[0]) * 24 * 3600) +
                (int.parse(timers[1]) * 3600) +
                (int.parse(timers[2]) * 60);
            _getStorage.write('timers', {'totall': totall});
          }
        }
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
                  "data:image/png;base64,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"),
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

    return statics!['totall'] ~/ 2;
    // return 0;
  }
  Map<String, dynamic> get timersLocal {
    var statics = _getStorage.read('timers') ?? {};
    return statics;
  }
}
