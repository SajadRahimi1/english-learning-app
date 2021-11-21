import 'dart:convert';

import 'package:get/get.dart';
import 'package:zabaner/models/category_content_model.dart';
import 'package:zabaner/models/urls.dart';

class NewsDataController extends GetConnect {
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
    var response = await get(newsCagetoryUrl);
    categories.addAll(jsonDecode(response.bodyString ?? "[]"));
    getContent(categories[0]);
  }

  void getContent(String category) async {
    content.clear();
    var req = await get(newsCategoryContentUrl, query: {'category': category});

    content.addAll(categoryContentFromJson(req.bodyString ?? ""));
  }
}
