import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/screens/main_screen.dart';

class ValidateController extends GetConnect {
  final GetStorage _getStorage = GetStorage();
  @override
  void onInit() {
    super.onInit();
    GetStorage.init();
  }

  Future<void> validateSignup(String phoneNumber, String code) async {
    var _request =
        await post(validateCodeUrl, {"mobile": phoneNumber, "code": code});
    if (_request.statusCode == 201) {
      print(_request.body['accessToken'].toString());
      Get.offAll(() => MainScreen(
            isGuest: false,
          ));
      _getStorage.write('token', _request.body['accessToken'].toString());
    }
  }
}
