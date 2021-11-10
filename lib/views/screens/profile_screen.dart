import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/views/screens/profile_account_screen.dart';
import 'package:zabaner/views/screens/profile_setting_screen.dart';
import 'package:zabaner/views/screens/profile_support_screen.dart';

import 'package:zabaner/views/widgets/profile_tab_widget.dart';

class ProfileScreen extends StatelessWidget {
  var tab = [
    true,
    false,
    false,
  ].obs;
  final tabWidget = [ProfileAccount(), ProfileSupport(), ProfileSetting()];
  var tabIndex = 0.obs;

  ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xffffffff),
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
                        backgroundImage: const NetworkImage(
                            "https://randomuser.me/api/portraits/med/men/40.jpg"),
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
                                    image: tab[0] == true
                                        ? "account_enable2.png"
                                        : "account_disable2.png",
                                    onTap: () {
                                      tab.value = List.filled(3, false);
                                      tab[0] = true;
                                      tabIndex.value = 0;
                                    },
                                  )),
                              Obx(() => ProfileTab(
                                    image: tab[1] == true
                                        ? "support_enable2.png"
                                        : "support_disable2.png",
                                    onTap: () {
                                      tab.value = List.filled(3, false);
                                      tab[1] = true;
                                      tabIndex.value = 1;
                                    },
                                  )),
                              Obx(() => ProfileTab(
                                    image: tab[2] == true
                                        ? "setting_enable2.png"
                                        : "setting_disable2.png",
                                    onTap: () {
                                      tab.value = List.filled(3, false);
                                      tab[2] = true;
                                      tabIndex.value = 2;
                                    },
                                  )),
                              const ProfileTab(image: "exit.png"),
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

                Expanded(child: Obx(() => tabWidget[tabIndex.value]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
