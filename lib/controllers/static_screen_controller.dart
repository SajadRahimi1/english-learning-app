import 'package:get/get.dart';
import 'package:zabaner/models/summary_time_static_model.dart';
import 'package:zabaner/models/urls.dart';

class StaticController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  late SummaryTimeStatic summaryTime;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSummaryData("token");
  }

  void getSummaryData(String token) async {
    var _request = await _getConnect.get(
      summaryTimeUrl,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $tokenConst'
      },
    );

    if (_request.statusCode == 200) {
      summaryTime = summaryTimeSttaticFromJson(_request.bodyString ?? "");
      change(null, status: RxStatus.success());
    }
  }
}
