import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/screens/main_screen.dart';

class LoginController extends GetConnect {
  var error = false.obs;
  var errorMessage = "".obs;
  var loginCheck = false.obs;
  final GetStorage _getStorage = GetStorage();
  @override
  void onInit() async {
    super.onInit();
    await GetStorage.init();
    if (_getStorage.read('token') != null) {
      final _request = await get(profileInformationUrl, headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ${_getStorage.read('token')}'
      });
      if (_request.statusCode == 200) {
        Get.offAll(() => MainScreen(
              isGuest: false,
            ));
      } else {
        loginCheck.value = true;
      }
    } else {
      loginCheck.value = true;
    }
  }

  Future<void> login(String username, String password, bool rememberMe) async {
    var _response =
        await post(signinUrl, {"username": username, "password": password});

    if (_response.statusCode == 201) {
      if (rememberMe) {
        print(_response.body['accessToken']);
        _getStorage.write('token', _response.body['accessToken'].toString());
        Get.offAll(() => MainScreen(
              isGuest: false,
            ));
      } else {
        // Get.offAll(() => MainScreen());
      }
    }
    if (_response.statusCode == 400) {
      error.value = true;
      errorMessage.value = "نام کاربری یا رمز عبور صحیح نمی‌باشد";
    }
  }
}
