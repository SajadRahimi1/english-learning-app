import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/home_model.dart';
import 'package:zabaner/models/urls.dart';

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

  void getData(String token) async {
    var request = await _getConnect.get(homeDataUrl, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer $tokenConst'
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
}
