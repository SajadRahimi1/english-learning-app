import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zabaner/models/urls.dart';

 void main() {
  final GetConnect getConnect = GetConnect();
  List cate = [].obs;
  List content = [];
  test('Get News Category', ()async{
    var response = await getConnect.get(newsCagetoryUrl);

    cate.addAll(jsonDecode(response.bodyString??"{[]}"));

    for (var item in cate) {
      var req = await getConnect.get(newsCategoryContentUrl,query: {
        'category':item
      });

      content.addAll(jsonDecode(req.bodyString??"{[]}"));

      print(content[0]);
    }

  });
}
