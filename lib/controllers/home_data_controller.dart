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
    try {
      Map<String, dynamic> times = _getStorage.read('timers') ?? {};

      if (times.isNotEmpty) {
        var stats = [];
        times.forEach((key, value) {
          if (key != 'totall') {
            stats.add({
              "date": key,
              "duration":
                  ((int.parse(value.toString()) / 3) * 2).toInt().formatSecond()
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

  void getData(String token) async {
    print(_getStorage.read('token'));
    var request = await _getConnect.get(homeDataUrl, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer ${_getStorage.read('token')}'
    });

    if (request.statusCode == 200) {
      homeModel = homeModelFromJson(request.bodyString ?? "");
      _getStorage.write('profile_image', homeModel.user.avatarPath);
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
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
