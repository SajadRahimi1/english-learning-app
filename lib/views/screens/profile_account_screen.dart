import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/views/widgets/custom_text_input_profile.dart';

class ProfileAccount extends StatelessWidget {
  static const List textHint = [
    "نام",
    "نام خانوادگی",
    "تاریخ تولد",
    "ایمیل",
    "موبایل"
  ];

  const ProfileAccount({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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

        Card(
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
                  CircleAvatar(
                    radius: Get.width / 6.5,
                    backgroundImage: const NetworkImage(
                        "https://randomuser.me/api/portraits/med/men/40.jpg"),
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
                        hintText: textHint[0],
                        iconPath: "username.png",
                      )),

                  // last name text input
                  SizedBox(
                      height: Get.height / 23,
                      width: Get.width / 1.5,
                      // color: Colors.green,
                      child: CustomTextInputProfile(
                        hintText: textHint[1],
                        iconPath: "username.png",
                      )),

                  // birthday date text input
                  SizedBox(
                      height: Get.height / 23,
                      width: Get.width / 1.5,
                      // color: Colors.green,
                      child: CustomTextInputProfile(
                        hintText: textHint[2],
                        iconPath: "birthday.png",
                      )),

                  // email text input
                  SizedBox(
                      height: Get.height / 23,
                      width: Get.width / 1.5,
                      child: CustomTextInputProfile(
                        hintText: textHint[3],
                        isEnabled: false,
                        iconPath: "email.png",
                      )),

                  // mobile text input
                  SizedBox(
                      height: Get.height / 23,
                      width: Get.width / 1.5,
                      child: CustomTextInputProfile(
                        hintText: textHint[4],
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
                        onPressed: () {},
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
        ),
      ],
    );
  }
}
