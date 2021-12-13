import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/bool_model.dart';
import 'package:zabaner/models/urls.dart';

class BookController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  final GetStorage _getStorage = GetStorage();
  late BookModel bookDetail;
  late DateTime _dateTime;
  var seconds = 0;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("Init");
    GetStorage.init();
    _dateTime = DateTime.now();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    var lastTimer = _getStorage.read(
            "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}") ??
        0;
    _getStorage.write(
        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
        DateTime.now().difference(_dateTime).inSeconds + lastTimer);
    print(_getStorage.read(
        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}"));

    _getStorage.remove('timers');
  }

  void getBookDetail(String token, String bookId) async {
    var request = await _getConnect.get(
      getBookDetailUrl + bookId,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $tokenConst'
      },
    );

    if (request.statusCode == 200) {
      bookDetail = bookModelFromJson(request.bodyString ?? "");
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
  }
}
