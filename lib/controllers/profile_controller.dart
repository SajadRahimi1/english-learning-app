import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/models/profile_information_model.dart';
import 'package:zabaner/models/urls.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController with StateMixin {
  ProfileController(this.isGuest);
  final GetConnect _getConnect = GetConnect();
  late ProfileInformation profileInformation;
  final GetStorage _getStorage = GetStorage();
  final bool isGuest;

  @override
  void onInit() {
    super.onInit();
    GetStorage.init();
    getProfileInformation(isGuest);
  }

  Future<void> getProfileInformation(bool isGuest) async {
    if (!isGuest) {
      change(null, status: RxStatus.loading());
      final _request = await _getConnect.get(profileInformationUrl, headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ${_getStorage.read('token')}'
      });
      if (_request.statusCode == 200) {
        profileInformation =
            profileInformationFromJson(_request.bodyString ?? "");
        change(null, status: RxStatus.success());
        _getStorage.write('profile_image', profileInformation.avatarPath);
      } else {
        print(_request.body);
        change(null, status: RxStatus.error());
      }
    } else {
      profileInformation = ProfileInformation(
          email: "Guest@zabaner.com",
          mobile: "",
          firstName: "Guest",
          lastName: "",
          bDay: DateTime.now(),
          username: "Guest",
          registerMethod: "Guest");
      change(null, status: RxStatus.success());
    }
  }

  void getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);

    var request = http.MultipartRequest("PATCH", Uri.parse(updateProfileUrl));

    request.headers["Authorization"] = "Bearer ${_getStorage.read('token')}";

    try {
      var pic = await http.MultipartFile.fromPath('avatar', _image!.path);

      request.files.add(pic);
      var response = await request.send();

      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      if (response.statusCode == 200) {
        getProfileInformation(isGuest);
      }
      print(responseString);
    } catch (e) {}
  }

  void updateProfile(String firstName, String lastName, String birthday) async {
    var _request = await _getConnect.patch(updateProfileUrl, {
      'firstName': firstName,
      'lastName': lastName,
      'bDay': birthday
    }, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer ${_getStorage.read('token')}'
    });

    if (_request.statusCode == 200) {
      getProfileInformation(isGuest);
    } else {
      change(null, status: RxStatus.error());
    }
  }
}
