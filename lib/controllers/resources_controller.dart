import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/resources_model.dart';
import 'package:zabaner/models/urls.dart';

class ResourcesController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  List<ResourcesData> resourcesList = [];

  @override
  void onInit() async {
    super.onInit();
    getResources();
    GetStorage.init();
  }

  Future<void> getResources() async {
    var request = await _getConnect
        .get(resourcesUrl, headers: {'accept': 'application/json'});
    if (request.statusCode == 200) {
      resourcesList.addAll(resourcesFromJson(request.bodyString ?? ""));
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
  }

  get getProfileImage {
    final GetStorage _getStorage = GetStorage();
    return _getStorage.read('profile_image');
  }
}
