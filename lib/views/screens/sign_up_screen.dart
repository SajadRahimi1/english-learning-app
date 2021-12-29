import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/controllers/signup_controller.dart';
import 'package:zabaner/views/widgets/custom_check_box.dart';
import 'package:zabaner/views/widgets/custom_text_input.dart';

import '../colors.dart';

class SignupScreen extends StatelessWidget {
  static const textInputDetail = [
    ["نام کاربری", "رمز عبور", "تکرار رمز عبور", "شماره موبایل", "ایمیل"],
    ["username.png", "lock.png", "repassword.png", "mobile.png", "email2.png"]
  ];

  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignupController _controller = Get.put(SignupController());
    List signupParamerts = ["", " ", "", "", ""];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffffffff),
        body: Column(
          children: [
            // Back Button
            Padding(
              padding:
                  EdgeInsets.only(right: Get.width / 20, top: Get.height / 35),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  children: const [
                    Icon(
                      Icons.arrow_back,
                      size: 18,
                    ),
                    Text("بازگشت",
                        style: TextStyle(fontFamily: "Yekan", fontSize: 12)),
                  ],
                ),
              ),
            ),

            //Logo in top of page
            Padding(
              padding: EdgeInsets.only(bottom: Get.height / 39),
              child: SizedBox(
                height: Get.height / 8,
                width: Get.width / 2,
                child: Image.asset(
                  "assets/images/zabaner_logo.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),

            // Signup Paramerts
            Container(
                width: Get.width / 1.25,
                height: Get.height / 1.8,
                decoration: BoxDecoration(
                    color: const Color(0xfff5f5f5),
                    borderRadius: BorderRadius.circular(36)),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: Get.width / 10, vertical: Get.height / 45),
                  child: Column(
                    children: [
                      // top widget texts
                      SizedBox(
                        width: Get.width,
                        height: Get.height / 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Text(
                                "ثبت نام کنید",
                                style: TextStyle(
                                    fontSize: 13, fontFamily: "Yekan"),
                              ),
                            ),
                            Text(
                              "جهت دسترسی به برنامه نیاز به  ورود اطلاعات است",
                              style: TextStyle(
                                  fontSize: 8,
                                  fontFamily: "Yekan",
                                  color: Color(0xff9F9F9F)),
                            ),
                          ],
                        ),
                      ),

                      //login text input and remember me custom check box
                      SizedBox(
                          height: Get.height / 3.5,
                          // color: Colors.red,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                  6,
                                  (index) => index == 5
                                      ? customCheckBox(
                                          Get.width / 22,
                                          Get.height / 40,
                                          "   استفاده از زبانر به معنی موافقت با قوانین می باشد",
                                          (value) {},
                                          false)
                                      : SizedBox(
                                          width: Get.width,
                                          height: Get.height / 23,
                                          child: Obx(() => CustomTextInput(
                                                hintText: textInputDetail[0]
                                                    [index],
                                                iconPath: textInputDetail[1]
                                                    [index],
                                                error: _controller.error.value,
                                                keyboardType: index == 3
                                                    ? TextInputType.phone
                                                    : TextInputType
                                                        .emailAddress,
                                                onChanged: (text) {
                                                  signupParamerts[index] = text;
                                                },
                                              )),
                                        )))),

                      //login button
                      InkWell(
                        onTap: () {
                          if (signupParamerts[1] == signupParamerts[2] &&
                              signupParamerts[0].toString().isNotEmpty &&
                              signupParamerts[3].toString().isNotEmpty) {
                            _controller.signup(
                                signupParamerts[0],
                                signupParamerts[1],
                                signupParamerts[3],
                                signupParamerts[4]);
                          } else {
                            if (signupParamerts[1] != signupParamerts[2]) {
                              Get.snackbar("", "",
                                  messageText: const Text(
                                    "رمز عبور با تکرار رمز عبور یکسان نیست",
                                    textAlign: TextAlign.right,
                                  ));
                            } else {
                              Get.snackbar("", "",
                                  messageText: const Text(
                                    "لطفا تمام فیلد ها را پر کنید",
                                    textAlign: TextAlign.right,
                                  ));
                            }
                          }
                        },
                        child: Container(
                          width: Get.width,
                          height: Get.height / 26,
                          margin:
                              EdgeInsets.symmetric(vertical: Get.height / 60),
                          decoration: BoxDecoration(
                              color: orange,
                              borderRadius: BorderRadius.circular(11)),
                          child: const Center(
                            child: Text(
                              "ثبت نام",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Yekan",
                                  color: Color(0xffffffff)),
                            ),
                          ),
                        ),
                      ),

                      // login with gmail button
                      Container(
                        height: Get.height / 23,
                        margin: EdgeInsets.symmetric(
                            horizontal: Get.width / 10,
                            vertical: Get.height / 50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: orange, width: 0.8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("ثبت نام با حساب کاربری گوگل",
                                style: TextStyle(
                                    color: Color(0xff616161),
                                    fontFamily: "Yekan",
                                    fontSize: 9)),
                            Image.asset(
                              "assets/images/gmail.png",
                              width: Get.width / 12,
                              height: Get.height / 45,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),

            // Image in bottom Center
            SizedBox(
              height: Get.height / 5.5,
              width: Get.width,
              // color: Colors.red,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    "assets/images/signup_image.png",
                    width: Get.width / 3.2,
                    // height: Get.height / 8,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
