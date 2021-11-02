import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/views/widgets/custom_text_input.dart';

import '../colors.dart';

class RecoveryPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              child: SizedBox(
                // width: Get.width,
                // height: Get.height / 12,

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
                height: Get.height / 3.4,
                decoration: BoxDecoration(
                    color: const Color(0xfff5f5f5),
                    borderRadius: BorderRadius.circular(36)),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: Get.width / 10, vertical: Get.height / 35),
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
                                "فراموشی رمز عبور",
                                style: TextStyle(
                                    fontSize: 13, fontFamily: "Yekan"),
                              ),
                            ),
                            Text(
                              "لطفا جهت بازیابی اطلاعات شماره موبایل یا ایمیل خود را وارد کنید",
                              style: TextStyle(
                                  fontSize: 8,
                                  fontFamily: "Yekan",
                                  color: Color(0xff9F9F9F)),
                            ),
                          ],
                        ),
                      ),

                      // Email or phone number text input
                      SizedBox(
                          height: Get.height / 23,
                          // color: Colors.red,
                          child: CustomTextInput(
                            hintText: "ایمیل یا شماره همراه",
                            iconPath: "key.png",
                          )),

                      //login button
                      Container(
                          width: Get.width,
                          height: Get.height / 13,
                          padding:
                              EdgeInsets.symmetric(vertical: Get.height / 45),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              "بازیابی",
                              style:
                                  TextStyle(fontSize: 12, fontFamily: "Yekan"),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(orange),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8)))),
                          )),

                      // Connect to support
                      Padding(
                        padding: EdgeInsets.only(top: Get.height / 60),
                        child: SizedBox(
                          height: Get.height / 28,
                          width: Get.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text("اطلاعات ورود خود را فراموش کرده اید؟",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Color(0xff9F9F9F),
                                    fontFamily: "Yekan",
                                  )),
                              InkWell(
                                child: Text("ارتباط با پشتیبانی",
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: orange,
                                      fontFamily: "Yekan",
                                    )),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),

            // Image in bottom Center
            SizedBox(
              height: Get.height / 3,
              width: Get.width,
              // color: Colors.red,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    "assets/images/signup_image.png",
                    width: Get.width / 1.6,
                    // height: Get.height / 8,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
