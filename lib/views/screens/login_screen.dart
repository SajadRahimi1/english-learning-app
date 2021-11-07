import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:zabaner/controllers/login_controller.dart';
import 'package:zabaner/views/colors.dart';
import 'package:zabaner/views/screens/main_screen.dart';
import 'package:zabaner/views/screens/recovery_password.dart';
import 'package:zabaner/views/screens/sign_up_screen.dart';
import 'package:zabaner/views/widgets/custom_check_box.dart';
import 'package:zabaner/views/widgets/custom_text_input.dart';

class LoginScreen extends StatelessWidget {
  static const textInputDetail = [
    ["نام کاربری", "رمز عبور"],
    ["username.png", "lock.png"]
  ];
  @override
  Widget build(BuildContext context) {
    final LoginController _controller = Get.put(LoginController());
    String username = "", password = "";
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width / 12, vertical: Get.height / 22),
            child: Column(
              children: [
                //Logo in top of page
                SizedBox(
                  height: Get.height / 8,
                  width: Get.width / 2,
                  child: Image.asset(
                    "assets/images/zabaner_logo.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),

                // Login Paramets in center of page
                Expanded(
                    flex: 8,
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xfff5f5f5),
                          borderRadius: BorderRadius.circular(36)),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: Get.width / 10,
                            vertical: Get.height / 35),
                        child: Column(
                          children: [
                            // top widget texts
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 6),
                                        child: Text(
                                          "وارد شوید",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: "Yekan"),
                                        ),
                                      ),
                                      Text(
                                        "جهت دسترسی به پورتال خود نیاز به اطلاعات ورود است",
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontFamily: "Yekan",
                                            color: Color(0xff9F9F9F)),
                                      ),
                                    ],
                                  ),
                                )),

                            //login text input and remember me custom check box
                            Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: CustomTextInput(
                                        hintText: textInputDetail[0][0],
                                        iconPath: textInputDetail[1][0],
                                        onChanged: (text) {
                                          username = text;
                                        },
                                      ),
                                      width: Get.width,
                                      height: Get.height / 23,
                                    ),
                                    SizedBox(
                                      child: CustomTextInput(
                                        hintText: textInputDetail[0][1],
                                        iconPath: textInputDetail[1][1],
                                        onChanged: (text) {
                                          password = text;
                                        },
                                      ),
                                      width: Get.width,
                                      height: Get.height / 23,
                                    ),
                                    CustomCheckBox(
                                        Get.width / 20,
                                        Get.height / 35,
                                        "   ذخیره اطلاعات ورود")
                                  ],
                                )),

                            //login button
                            Container(
                                width: Get.width,
                                height: Get.height / 10,
                                padding: EdgeInsets.symmetric(
                                    vertical: Get.height / 32),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _controller.login(username, password);
                                  },
                                  child: const Text(
                                    "ورود",
                                    style: TextStyle(
                                        fontSize: 12, fontFamily: "Yekan"),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(orange),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)))),
                                )),

                            // create account and forgot password text button
                            Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "حساب کاربری ندارید؟",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff9F9F9F),
                                              fontFamily: "Yekan"),
                                        ),
                                        InkWell(
                                          onTap: () => Get.to(
                                            () => SignupScreen(),
                                          ),
                                          child: const Text(
                                            "ایجاد کنید",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: orange,
                                                fontFamily: "Yekan"),
                                          ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () => Get.to(
                                          () => RecoveryPasswordScreen()),
                                      child: Text(
                                        "رمز عبور خود را فرموش کرده ام",
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: orange,
                                            fontFamily: "Yekan"),
                                      ),
                                    ),
                                  ],
                                )),

                            // login with gmail button
                            Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: Get.width / 8,
                                      vertical: Get.height / 90),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: orange, width: 0.5)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("ورود با حساب کاربری گوگل ",
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
                                )),
                          ],
                        ),
                      ),
                    )),

                // Trouble image in center bottom
                Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.all(Get.width / 20),
                      child: Image.asset(
                        "assets/images/TROUBLE.png",
                      ),
                    )),

                // Buttons and texts in bottom center
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("مشکل در ورود به حساب خود دارید؟",
                            style: TextStyle(
                                fontFamily: "Yekan",
                                fontSize: 13,
                                color: Color(0xff858585))),

                        // Login as geust
                        SizedBox(
                            width: Get.width / 1.5,
                            height: Get.height / 24,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(MainScreen());
                              },
                              child: const Text("ورود به عنوان میهمان",
                                  style: TextStyle(
                                      fontFamily: "Yekan", fontSize: 12)),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(orange),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)))),
                            )),

                        // Connect to support
                        InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "ارتباط با پشتیبانی",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: orange,
                                    fontFamily: "Yekan"),
                              ),
                              Image.asset(
                                "assets/images/support.png",
                                height: Get.height / 45,
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            )),
      ),
    );
  }
}
