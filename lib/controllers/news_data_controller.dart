import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/category_content_model.dart';
import 'package:zabaner/models/urls.dart';

class NewsDataController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  var categories = [].obs;

  RxList<CategoryContent> content = [
    CategoryContent(
        bookmark: false,
        imagePath: "",
        createdAt: DateTime(1),
        description: "",
        id: "",
        title: "")
  ].obs;
  @override
  void onInit() async {
    super.onInit();
    GetStorage.init();
    change(null, status: RxStatus.loading());
    var response = await _getConnect.get(newsCagetoryUrl);
    categories.addAll(jsonDecode(response.bodyString ?? "[]"));
    getContent(categories[0]);
  }

  void getContent(String category) async {
    content.clear();
    var req = await _getConnect
        .get(newsCategoryContentUrl, query: {'category': category});
    if (req.statusCode == 200) {
      content.addAll(categoryContentFromJson(req.bodyString ?? ""));
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error("مشکل در ارتباط با سرور"));
    }
  }

  void bookmarkToggle(String id) async {
    var query = "type=news&bookmarkAbleId=$id";
    var _request = await _getConnect.post(
        bookmarkToggleUrl, {'type': 'news', 'bookmarkAbleId': id},
        headers: {
          'accept': 'application/json',
          // 'Authorization': 'Bearer $tokenConst'
        },
        contentType: "application/json");
    print(_request.body);
    if (_request.statusCode != 201) {
      Get.snackbar("Error", _request.statusText.toString());
    }
  }

  get getProfileImage {
    final GetStorage _getStorage = GetStorage();
    return _getStorage.read('profile_image');
  }
}

class NewsSearchController extends GetConnect {
  List<CategoryContent> searchContent = [];
  var searchState = "".obs;
  void search(String title) async {
    searchState.value = "loading";
    var _searchRequest =
        await get(newsCategoryContentUrl, query: {'title': title});

    if (_searchRequest.statusCode == 200) {
      searchContent.clear();
      searchContent
          .addAll(categoryContentFromJson(_searchRequest.bodyString ?? ""));
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
