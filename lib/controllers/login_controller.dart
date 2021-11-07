import 'dart:convert';
import 'package:get/get.dart';
import 'package:zabaner/models/urls.dart';

class LoginController extends GetConnect {
  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> login(String username, String password) async {
    var response =
        await post(signin_url, {"username": username, "password": password});

    print(response.statusCode);
    print(username + "\n" + password);
    print(response.statusText);
    response.bodyString!.isNotEmpty
        ? print(jsonDecode(response.bodyString ?? ""))
        : print("");
  }
}
