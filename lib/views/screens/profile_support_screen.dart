import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSupport extends StatelessWidget {
  const ProfileSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // text
        SizedBox(
          width: Get.width / 1.2,
          child: const Text(
            "پشتیبانی",
            style: TextStyle(
                color: Color(0xff686868), fontFamily: "Yekan", fontSize: 12),
          ),
        ),

        // Card in Middle of screen
        Card(
          color: const Color(0xffF9F9F9),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Container(
            height: Get.height / 2.8,
            width: Get.width / 1.1,
            margin: EdgeInsets.symmetric(
                horizontal: Get.width / 22, vertical: Get.height / 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // help text
                const Text(
                  "سوالات، پیشنهادات و انتقادات خود را می توانید با استفاده از ایمیل ثبت شده در زیر برای ما ارسال نمایید. ما همیشه آماده پاسخگویی هستیم",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Yekan",
                      fontSize: 11,
                      color: Color(0xff5a5a5a)),
                ),

                // Text input
                Container(
                  width: Get.width,
                  height: Get.height / 4,
                  decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(20)),
                  child: Stack(
                    children: [
                      Center(
                          child: SizedBox(
                        width: Get.width / 2.5,
                        child: Image.asset(
                          "assets/images/support_disable3.png",
                          fit: BoxFit.fill,
                        ),
                      )),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 7,
                        decoration: InputDecoration(
                            hintText: "متن مورد نظر خود را وارد کنید...",
                            hintStyle: const TextStyle(
                                fontFamily: "Yekan",
                                fontSize: 10,
                                color: Color(0xff6D6D6D)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: Get.width / 22, vertical: 2),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide.none)),
                      )
                    ],
                  ),
                ),

                // Send button
                SizedBox(
                    width: Get.width,
                    height: Get.height / 23,
                    child: ElevatedButton(
                      child: const Text(
                        "ارسال ",
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

        // Support email text
        SizedBox(
          width: Get.width / 1.2,
          child: const Text(
            "Support@Zabaner.ir",
            style: TextStyle(
                fontFamily: "Yekan", fontSize: 10, color: Color(0xff5A5A5A)),
            textAlign: TextAlign.left,
          ),
        ),

        // Zabaner Logo
        SizedBox(
            width: Get.width / 1.6,
            child:
                Image.asset("assets/images/signup_image.png", fit: BoxFit.fill))
      ],
    );
  }
}
