import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/views/colors.dart';
import 'package:zabaner/views/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: Get.height,
              width: Get.width,
              child: Image.asset(
                "assets/images/splash_background2.png",
                fit: BoxFit.fill,
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: Get.height / 20),
              child: SizedBox(
                height: Get.height / 8.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width / 1.8,
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => const LoginScreen()),
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w400),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(orange),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(52)))),
                      ),
                    ),
                    const Text(
                      "Version 5.2.1",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
