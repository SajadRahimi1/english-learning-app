import 'dart:convert';
import 'package:get/get.dart';
import 'package:zabaner/models/urls.dart';

class LoginController extends GetConnect {
  Future<void> login(String username, String password) async {
    var response =
        await post(signinUrl, {"username": username, "password": password});

    // print(response.statusCode);
    // print(username + "\n" + password);
    // print(response.statusText);
    // response.bodyString!.isNotEmpty
    //     ? print(jsonDecode(response.bodyString ?? ""))
    //     : print("");
  }
}
