import 'dart:convert';

import 'package:get/get.dart';
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
        title: "")
  ].obs;
  @override
  void onInit() async {
    super.onInit();
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
    } else {}
  }
}
