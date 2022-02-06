import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/support_message_model.dart';
import 'package:zabaner/models/urls.dart';

class SupportController extends GetxController {
  final GetConnect _getConnect = GetConnect();
  // create get storage to get token
  final GetStorage _getStorage = GetStorage();

  // create observer list
  var messagesList = <SupportMessageModel>[].obs;
  String message = "";
  // override onInit
  @override
  void onInit() {
    super.onInit();
    // allow auto certification(allowAutoCertification) in _getConnect
    _getConnect.allowAutoSignedCert = true;
    // init GetStorage
    GetStorage.init();
    getMessage();
  }

  Future<void> sendMessage() async {
    // send post request with GetConnect to sendSupportMessageUrl body is message and token in header
    final _response = await _getConnect.post(
        supportMessageUrl, {'message': message},
        headers: {'Authorization': 'Bearer ${_getStorage.read('token')}'});

    // if response is ok
    if (_response.statusCode == 201) {
      // show success message
      Get.snackbar(
        'پیام شما با موفقیت ارسال شد',
        '',
      );
      // add message to messagesList
      messagesList.insert(
          0,
          SupportMessageModel(
            user: "",
            id: "",
            createdAt: DateTime.now(),
            jalaliCreatedAt: "",
            message: message,
            type: "question",
          ));
    }
  }

  Future<void> getMessage() async {
    // get request with GetConnect to getSupportMessageUrl and token in header
    final _response = await _getConnect.get(supportMessageUrl,
        headers: {'Authorization': 'Bearer ${_getStorage.read('token')}'});
    // if response is ok add _response to _message
    if (_response.statusCode == 200) {
      var messages = supportMessageFromJson(_response.bodyString ?? "");
      // add message to messagesList
      messagesList.addAll(messages);
    }
  }
}
