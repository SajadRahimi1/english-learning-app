import 'package:get/get.dart';
import 'package:zabaner/models/profile_information_model.dart';
import 'package:zabaner/models/urls.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class ProfileController extends GetxController with StateMixin {
  final GetConnect _getConnect = GetConnect();
  late ProfileInformation profileInformation;
  final ImagePicker _picker = ImagePicker();
  @override
  void onInit() {
    super.onInit();

    getProfileInformation("token");
  }

  Future<void> getProfileInformation(String token) async {
    change(null, status: RxStatus.loading());
    final _request = await _getConnect.get(profileInformationUrl, headers: {
      'accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWFiMjdmOGY4OGEwYjEyZjUwMzBiMTUiLCJpYXQiOjE2Mzg3NzIzODksImV4cCI6MTYzODgwODM4OX0.G58g83TMQPC2-GtdparASJu9Ys9n-F8e8aXGJy4ZsnI'
    });
    if (_request.statusCode == 200) {
      profileInformation =
          profileInformationFromJson(_request.bodyString ?? "");
      change(null, status: RxStatus.success());
    }
  }

  void getImage() async {}
}
