import 'package:get/get.dart';
import 'package:zabaner/models/bool_model.dart';
import 'package:zabaner/models/urls.dart';

class BookController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  late BookModel bookDetail;
  void getBookDetail(String token, String bookId) async {
    var request = await _getConnect.get(
      getBookDetailUrl + bookId,
      headers: {
        'accept': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWFiMjdmOGY4OGEwYjEyZjUwMzBiMTUiLCJpYXQiOjE2Mzg3NzIzODksImV4cCI6MTYzODgwODM4OX0.G58g83TMQPC2-GtdparASJu9Ys9n-F8e8aXGJy4ZsnI'
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
