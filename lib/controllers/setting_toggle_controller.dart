import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

class SettingToggle extends GetxController {
  final GetStorage box = GetStorage();
  RxBool autoDownload = false.obs;
  RxBool saveStorage = false.obs;
  RxBool darkTheme = false.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await GetStorage.init();
    autoDownload.value = box.read('auto_download') ?? false;
    saveStorage.value = box.read('save_storage') ?? false;
    darkTheme.value = box.read('dark_theme') ?? false;
  }
}
