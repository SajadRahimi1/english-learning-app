import 'package:get/get.dart';
import 'package:zabaner/models/resources_model.dart';
import 'package:zabaner/models/urls.dart';

class ResourcesController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  List<ResourcesData> resourcesList = [];

  @override
  void onInit() async {
    super.onInit();
    getResources();
  }

  Future<void> getResources() async {
    var request = await _getConnect.get(resourcesUrl);
    if (request.statusCode == 200) {
      resourcesList.addAll(resourcesFromJson(request.bodyString ?? ""));
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
  }
}
