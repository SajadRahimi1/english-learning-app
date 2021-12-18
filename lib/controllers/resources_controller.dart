import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/resource_search_model.dart';
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

class ResourcesSearch extends GetConnect {
  var searchState = "".obs;
  List<ResourceSearchModel> searchContent = [];
  void search(String title) async {
    searchState.value = "loading";
    var _request = await get(resourcesSearchUrl, query: {'title': title});
    if (_request.statusCode == 200) {
      searchContent.clear();
      searchContent
          .addAll(resourceSearchModelFromJson(_request.bodyString ?? ""));
      if (searchContent.isNotEmpty) {
        searchState.value = "success";
      }
      if (searchContent.isEmpty) {
        searchContent.clear();
        searchState.value = "empty";
      }
    } else {
      searchState.value = "error";
    }
  }
}
