import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/views/widgets/custom_text_input.dart';

import '../colors.dart';

class SetNewPasswordScreen extends StatelessWidget {
  const SetNewPasswordScreen({Key? key}) : super(key: key);

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
                height: Get.height / 2.8,
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
                                "تغییر رمز عبور",
                                style: TextStyle(
                                    fontSize: 13, fontFamily: "Yekan"),
                              ),
                            ),
                            Text(
                              "لطفا رمز عبور جدید را وارد نمایید",
                              style: TextStyle(
                                  fontSize: 8,
                                  fontFamily: "Yekan",
                                  color: Color(0xff9F9F9F)),
                            ),
                          ],
                        ),
                      ),

                      // password and repet password text input
                      SizedBox(
                          height: Get.height / 10.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: Get.height / 23,
                                child: const CustomTextInput(
                                  hintText: "رمز عبور جدید",
                                  error: false,
                                  iconPath: "lock.png",
                                ),
                              ),
                              SizedBox(
                                height: Get.height / 23,
                                child: const CustomTextInput(
                                  hintText: "تکرار رمز عبور",
                                  iconPath: "repassword.png",
                                  error: false,
                                ),
                              ),
                            ],
                          )),

                      // Hint text
                      SizedBox(
                          width: Get.width,
                          height: Get.height / 20,
                          child: const Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "رمز انتخابی  شما باید حداقل 8 کاراکتر شامل حروف، اعداد و حداقل یک کاراکتر  ویژه باشد.",
                              style: TextStyle(
                                  color: Color(0xff9F9F9F),
                                  fontFamily: "Yekan",
                                  fontSize: 9),
                            ),
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
                              "تغییر رمز عبور",
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
                    ],
                  ),
                )),

            // Image in bottom Center
            SizedBox(
              height: Get.height / 3.8,
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
