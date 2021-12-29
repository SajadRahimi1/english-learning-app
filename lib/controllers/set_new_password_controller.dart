import 'package:get/get.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/screens/login_screen.dart';

class SetNewPasswordController extends GetConnect {
  Future<void> sendData(String code, String mobail, String password) async {
    var _request = await post(
      setNewPasswordUrl,
      mobail.isPhoneNumber
          ? {"code": code, "password": password, "mobile": mobail}
          : {
              "code": code,
              "password": password,
              "email": mobail,
            },
    );
    print(_request.body);
    if (_request.statusCode == 201) {
      Get.snackbar("password", "password change successful!");
      Get.offAll(() => LoginScreen());
    } else {
      if (_request.body['error'] == 4011) {
        Get.snackbar("password", "code was not successful");
        Get.back();
      }
    }
  }
}
