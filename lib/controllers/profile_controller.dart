import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:zabaner/models/profile_information_model.dart';
import 'package:zabaner/models/urls.dart';
import 'package:image_picker/image_picker.dart';

// import 'i';
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
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWFiMjdmOGY4OGEwYjEyZjUwMzBiMTUiLCJpYXQiOjE2Mzg2MDY4ODUsImV4cCI6MTYzODY0Mjg4NX0.Bw83ffIZY137Hs6aphXE27e-rc_TjiebJZLtZZ9jpVo'
    });
    if (_request.statusCode == 200) {
      profileInformation =
          profileInformationFromJson(_request.bodyString ?? "");
      change(null, status: RxStatus.success());
      update();
    }
  }

  Future<void> getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    print(_getConnect.timeout);

    var img = MultipartFile(image?.path, filename: image!.name);
    // final form = FormData(
    //   {
    //     'username': "sajad",
    //     'firstName': "sajad",
    //     "rahimi": "lastName",
    //     "bDay": "2020-07-10 15:00:00.000",
    //     "password": "sajadsajad",
    //     "avatar": MultipartFile(image.path, filename: image.name)
    //   },
    // );
    // // var req = await _getConnect.patch("http://138.201.100.200/api/update/profile/image", form,
    //     headers: {
    //       'accept': 'application/json',
    //       'Authorization':
    //           'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWFiMjdmOGY4OGEwYjEyZjUwMzBiMTUiLCJpYXQiOjE2Mzg2MDY4ODUsImV4cCI6MTYzODY0Mjg4NX0.Bw83ffIZY137Hs6aphXE27e-rc_TjiebJZLtZZ9jpVo'
    //     },
    //     uploadProgress: (percent) => print(percent.round().toString()));

    final form = FormData(
      {
        'token': "0c03cd85-a59b-4d87-9500-4ff33400ccc9",
        "image": MultipartFile(image.path, filename: image.name)
      },
    );

    var req = await _getConnect.put(
        "http://138.201.100.200/api/update/profile/image", form,
        uploadProgress: (percent) => print(percent.round().toString()));
    if (req.statusCode == 200) {
      change(null, status: RxStatus.loading());
      getProfileInformation("token");
    }
  }
}
