import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/views/screens/set_new_password.dart';
import 'package:zabaner/views/widgets/reset_password_code.dart';

import '../colors.dart';

class ValidateResetPasswordCode extends StatelessWidget {
  const ValidateResetPasswordCode({Key? key}) : super(key: key);

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
                height: Get.height / 3.2,
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
                                "بازیابی",
                                style: TextStyle(
                                    fontSize: 13, fontFamily: "Yekan"),
                              ),
                            ),
                            Text(
                              "کد ارسال شده برای شماره همراه 09121234567 را وارد کنید",
                              style: TextStyle(
                                  fontSize: 8,
                                  fontFamily: "Yekan",
                                  color: Color(0xff9F9F9F)),
                            ),
                          ],
                        ),
                      ),

                      // Code text input
                      SizedBox(
                          height: Get.height / 19,
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(4,
                                  (index) => ResetPasswordCode(index: index)),
                            ),
                          )),

                      // Timer text
                      SizedBox(
                          width: Get.width,
                          height: 20,
                          child: const Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "مدت اعتبار کد ارسال شده  1:26",
                              style: TextStyle(
                                  color: Color(0xff9F9F9F),
                                  fontFamily: "Yekan",
                                  fontSize: 9),
                            ),
                          )),

                      //Validate button
                      Container(
                          width: Get.width,
                          height: Get.height / 13,
                          padding:
                              EdgeInsets.symmetric(vertical: Get.height / 45),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => const SetNewPasswordScreen());
                            },
                            child: const Text(
                              "اعتبار سنجی",
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

                      // Resend Reset Password Code
                      SizedBox(
                        height: Get.height / 35,
                        width: Get.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text("کد برای شما ارسال نشده است؟",
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Color(0xff9F9F9F),
                                  fontFamily: "Yekan",
                                )),
                            InkWell(
                                child: Text(
                              "ارسال مجدد کد",
                              style: TextStyle(
                                fontSize: 9,
                                color: orange,
                                fontFamily: "Yekan",
                              ),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                )),

            // Image in bottom Center
            SizedBox(
              height: Get.height / 3.2,
              width: Get.width,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    "assets/images/signup_image.png",
                    width: Get.width / 1.5,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
