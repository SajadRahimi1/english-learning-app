import 'package:get/get.dart';
import 'package:zabaner/models/book_list_model.dart';
import 'package:zabaner/models/urls.dart';

class BookListController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect(allowAutoSignedCert: true);

  @override
  void onInit() async {
    super.onInit();
    await getData();
  }

  late final List<BookListModel> model;
  Future<void> getData() async {
    final _request = await _getConnect.get(getBookDetailUrl);
    if (_request.statusCode == 200) {
      model = bookListModelFromJson(_request.bodyString ?? "");
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error(""));
    }
  }
}
