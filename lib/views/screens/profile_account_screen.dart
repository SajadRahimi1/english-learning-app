import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/controllers/profile_controller.dart';
import 'package:zabaner/views/widgets/custom_text_input_profile.dart';

class ProfileAccount extends StatelessWidget {
  const ProfileAccount({Key? key, required this.isGuest}) : super(key: key);
  final bool isGuest;
  static const List textHint = [
    "نام",
    "نام خانوادگی",
    "تاریخ تولد",
    "ایمیل",
    "موبایل"
  ];

  @override
  Widget build(BuildContext context) {
    final ProfileController _controller = Get.put(ProfileController(isGuest));
    final GetStorage _getStorage = GetStorage();
    GetStorage.init();
    return Column(
      children: [
        // text
        SizedBox(
          width: Get.width / 1.2,
          child: const Text(
            "تنظیمات حساب کاربری",
            style: TextStyle(
                color: Color(0xff686868), fontFamily: "Yekan", fontSize: 12),
          ),
        ),

        _controller.obx((status) {
          List information = [
            _controller.profileInformation.firstName,
            _controller.profileInformation.lastName,
            _controller.profileInformation.bDay.toString()
          ];
          return Card(
            color: const Color(0xffF9F9F9),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: SizedBox(
              height: Get.height / 1.7,
              width: Get.width / 1.1,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Get.width / 8, vertical: Get.height / 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Profile Image
                    InkWell(
                      onTap: () => isGuest ? {} : _controller.getImage(),
                      child: CircleAvatar(
                        radius: Get.width / 6.5,
                        backgroundImage: NetworkImage(_getStorage
                                .read('profile_image') ??
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Solid_white.svg/2048px-Solid_white.svg.png"),
                      ),
                    ),
                    const Text(
                      "تصویر پروفایل",
                      style: TextStyle(fontFamily: "Yekan", fontSize: 10),
                    ),

                    // name text input
                    SizedBox(
                        height: Get.height / 23,
                        width: Get.width / 1.5,
                        // color: Colors.green,
                        child: CustomTextInputProfile(
                          hintText: _controller.profileInformation.firstName,
                          iconPath: "username.png",
                          isEnabled: !isGuest,
                          onChanged: (text) => information[0] = text,
                        )),

                    // last name text input
                    SizedBox(
                        height: Get.height / 23,
                        width: Get.width / 1.5,
                        // color: Colors.green,
                        child: CustomTextInputProfile(
                          hintText: _controller.profileInformation.lastName,
                          iconPath: "username.png",
                          isEnabled: !isGuest,
                          onChanged: (text) => information[1] = text,
                        )),

                    // birthday date text input
                    SizedBox(
                        height: Get.height / 23,
                        width: Get.width / 1.5,
                        // color: Colors.green,
                        child: CustomTextInputProfile(
                            hintText: _controller.profileInformation.bDay.year
                                .toString(),
                            iconPath: "birthday.png",
                            isEnabled: !isGuest,
                            onChanged: (text) => information[2] =
                                DateTime(int.parse(text)).toString())),

                    // email text input
                    SizedBox(
                        height: Get.height / 23,
                        width: Get.width / 1.5,
                        child: CustomTextInputProfile(
                          hintText: _controller.profileInformation.email,
                          isEnabled: false,
                          iconPath: "email.png",
                        )),

                    // mobile text input
                    SizedBox(
                        height: Get.height / 23,
                        width: Get.width / 1.5,
                        child: CustomTextInputProfile(
                          hintText: _controller.profileInformation.mobile,
                          isEnabled: false,
                          iconPath: "mobile.png",
                        )),

                    // save changes button
                    SizedBox(
                        height: Get.height / 23,
                        width: Get.width / 1.5,
                        child: ElevatedButton(
                          child: const Text(
                            "ذخیره تغییرات",
                            style: TextStyle(fontFamily: "Yekan", fontSize: 12),
                          ),
                          onPressed: () {
                            _controller.updateProfile(
                              information[0],
                              information[1],
                              information[2],
                            );
                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xffFFC200))),
                        )),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
