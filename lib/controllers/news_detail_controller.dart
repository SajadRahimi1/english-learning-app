import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/news_detail_model.dart';
import 'package:zabaner/models/urls.dart';

class NewsDetailController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  late NewsDetailModel newsDetail;
  final GetStorage _getStorage = GetStorage();
  late DateTime _dateTime;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("Init");
    GetStorage.init();
    _dateTime = DateTime.now();
  }

  @override
  void onClose() async {
    // TODO: implement onClose
    super.onClose();

    Map times = _getStorage.read('timers') ?? {};
    var lastTimer = times[
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'] ??
        0;
    if (times[
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'] ==
        null) {
      times.addAll(<String, dynamic>{
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}':
            (DateTime.now().difference(_dateTime).inSeconds + lastTimer).toInt()
      });
    } else {
      times['${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'] =
          (DateTime.now().difference(_dateTime).inSeconds + lastTimer).toInt();
    }
    if (times['totall'] == null) {
      times.addAll(<String, dynamic>{
        'totall':
            (DateTime.now().difference(_dateTime).inSeconds + lastTimer).toInt()
      });
    } else {
      times['totall'] = times['totall'] +
          (DateTime.now().difference(_dateTime).inSeconds).toInt();
    }
    await _getStorage.write('timers', times);
    print(_getStorage.read('timers'));
  }

  Future<void> getData(String id) async {
    var _request = await _getConnect.get(newsDetailUrl + id, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer ${_getStorage.read('token')}'
    });

    if (_request.statusCode == 200) {
      newsDetail = newsDetailModelFromJson(_request.bodyString ?? "");
      change(null, status: RxStatus.success());
      print(_request.body);
    } else {
      change(null, status: RxStatus.error());
    }
  }
}
