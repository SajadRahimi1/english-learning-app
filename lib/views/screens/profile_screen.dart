import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/views/screens/login_screen.dart';
import 'package:zabaner/views/screens/profile_account_screen.dart';
import 'package:zabaner/views/screens/profile_setting_screen.dart';
import 'package:zabaner/views/screens/profile_support_screen.dart';
import 'package:zabaner/views/widgets/profile_tab_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key, required this.isGuest}) : super(key: key);
  final bool isGuest;
  final GetStorage _getStorage = GetStorage();
  @override
  Widget build(BuildContext context) {
    GetStorage.init();
    RxInt tab = 0.obs;
    final PageController _pageController = PageController();
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xffffffff),
          // resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 30),
            child: Column(
              children: [
                // top of profile screen
                SizedBox(
                  height: Get.height / 9,
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: Get.width / 13,
                        backgroundImage: NetworkImage(_getStorage
                                .read('profile_image') ??
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Solid_white.svg/2048px-Solid_white.svg.png"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Get.width / 23),
                        child: SizedBox(
                          height: Get.height / 10,
                          width: Get.width / 1.56,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() => ProfileTab(
                                    image: tab.value == 0
                                        ? "account_enable2.png"
                                        : "account_disable2.png",
                                    title: "Account",
                                    onTap: () => _pageController.jumpToPage(0),
                                  )),
                              Obx(() => ProfileTab(
                                    image: tab.value == 1
                                        ? "support_enable2.png"
                                        : "support_disable2.png",
                                    title: "Support",
                                    onTap: () => _pageController.jumpToPage(1),
                                  )),
                              Obx(() => ProfileTab(
                                    image: tab.value == 2
                                        ? "setting_enable2.png"
                                        : "setting_disable2.png",
                                    title: "Settings",
                                    onTap: () => _pageController.jumpToPage(2),
                                  )),
                              ProfileTab(
                                image: "exit.png",
                                title: "Log Out",
                                onTap: () async {
                                  await GetStorage.init();
                                  final GetStorage _getStorage = GetStorage();
                                  _getStorage.remove('timers');
                                  _getStorage.remove('token');
                                  _getStorage.remove('timers');
                                  Get.offAll(LoginScreen());
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // Empty Space Between text and top section
                SizedBox(
                  height: Get.height / 35,
                ),

                Expanded(
                    child: PageView(
                  onPageChanged: (int index) {
                    tab.value = index;
                  },
                  controller: _pageController,
                  children: [
                    ProfileAccount(
                      isGuest: isGuest,
                    ),
                    SingleChildScrollView(child: ProfileSupport()),
                    ProfileSetting(isGuest: isGuest)
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
