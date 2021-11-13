import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/views/widgets/custom_setting_card.dart';

class ProfileSetting extends StatelessWidget {
  var backupOnServer = false.obs;

  ProfileSetting({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Setting text
        SizedBox(
          width: Get.width / 1.2,
          child: const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "تنظیمات",
              style: TextStyle(
                  color: Color(0xff686868), fontFamily: "Yekan", fontSize: 12),
            ),
          ),
        ),

        // Setting Switches
        SizedBox(
          width: Get.width,
          height: Get.height / 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SettingCard(title: "دانلود خودکار صوت"),
              SettingCard(
                  title: "کارت حافظه محل پیش فرض برای ذخیره اطلاعات باشد"),
              SettingCard(title: "رنگ پوسته تیره شود"),
            ],
          ),
        ),

        // Backup options
        SizedBox(
          width: Get.width,
          height: Get.height / 5.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Manage Backup text
              SizedBox(
                width: Get.width / 1.2,
                child: const Text(
                  "مدیریت پشتیبان گیری",
                  style: TextStyle(
                      color: Color(0xff686868),
                      fontFamily: "Yekan",
                      fontSize: 9),
                ),
              ),

              // Backup on server Check box
              Card(
                color: const Color(0xffF9F9F9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                    width: Get.width,
                    height: Get.height / 20,
                    child: Container(
                      width: Get.width,
                      height: Get.height / 18,
                      margin: EdgeInsets.symmetric(
                          horizontal: Get.width / 35,
                          vertical: Get.height / 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "پشتیبان گیری روی سرور برنامه",
                            style: TextStyle(fontFamily: "Yekan", fontSize: 9),
                          ),
                          Obx(() => Checkbox(
                                checkColor: const Color(0xff000000),
                                fillColor: MaterialStateProperty.all(
                                    const Color(0xffffffff)),
                                activeColor: const Color(0xffffffff),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                side: const BorderSide(
                                    width: 0.5, color: Color(0xff707070)),
                                value: backupOnServer.value,
                                onChanged: (value) {
                                  backupOnServer.value = value ?? true;
                                },
                              ))
                        ],
                      ),
                    )),
              ),

              // Backup and restore buttons
              SizedBox(
                width: Get.width,
                height: Get.height / 26,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Make Backup button
                    SizedBox(
                      width: Get.width / 2.4,
                      height: double.infinity,
                      child: ElevatedButton(
                        child: const Text(
                          "تهیه نسخه پشتیبان",
                          style: TextStyle(fontFamily: "Yekan", fontSize: 10),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffFFC200)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)))),
                        onPressed: () {},
                      ),
                    ),

                    // Restore button
                    SizedBox(
                      width: Get.width / 2.4,
                      height: double.infinity,
                      child: ElevatedButton(
                        child: const Text(
                          "بازیابی",
                          style: TextStyle(fontFamily: "Yekan", fontSize: 10),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffD4D4D4)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)))),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),

              // Last Backup time text
              const Text(
                "آخرین زمان پشتیبان گیری تاریخ 30/06/00 در ساعت 14:08",
                style: TextStyle(
                    fontFamily: "Yekan", fontSize: 8, color: Color(0xff686868)),
              )
            ],
          ),
        ),

        // Connect to us Cards
        SizedBox(
          width: Get.width,
          height: Get.height / 4.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Setting text
              SizedBox(
                width: Get.width / 1.2,
                child: const Text(
                  "ارتباط با ما",
                  style: TextStyle(
                      color: Color(0xff686868),
                      fontFamily: "Yekan",
                      fontSize: 11),
                ),
              ),

              // Website address card
              Card(
                color: const Color(0xffF9F9F9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                    width: Get.width,
                    height: Get.height / 20,
                    child: Container(
                      width: Get.width,
                      height: Get.height / 18,
                      margin: EdgeInsets.symmetric(
                          horizontal: Get.width / 35,
                          vertical: Get.height / 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "وبسایت",
                            style: TextStyle(fontFamily: "Yekan", fontSize: 9),
                          ),
                          Row(
                            children: [
                              const Text(
                                "HTTP://ZABANER.IR  ",
                                style: TextStyle(
                                    fontFamily: "Yekan",
                                    fontSize: 9,
                                    color: Color(0xff5A5A5A)),
                              ),
                              Image.asset(
                                "assets/images/website.png",
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),

              // Instagram address card
              Card(
                color: const Color(0xffF9F9F9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                    width: Get.width,
                    height: Get.height / 20,
                    child: Container(
                      width: Get.width,
                      height: Get.height / 18,
                      margin: EdgeInsets.symmetric(
                          horizontal: Get.width / 35,
                          vertical: Get.height / 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "اینستاگرام",
                            style: TextStyle(fontFamily: "Yekan", fontSize: 9),
                          ),
                          Row(
                            children: [
                              const Text(
                                "Zabaner_Official  ",
                                style: TextStyle(
                                    fontFamily: "Yekan",
                                    fontSize: 9,
                                    color: Color(0xff5A5A5A)),
                              ),
                              Image.asset(
                                "assets/images/instagram.png",
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),

              // Telegram address card
              Card(
                color: const Color(0xffF9F9F9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                    width: Get.width,
                    height: Get.height / 20,
                    child: Container(
                      width: Get.width,
                      height: Get.height / 18,
                      margin: EdgeInsets.symmetric(
                          horizontal: Get.width / 35,
                          vertical: Get.height / 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "تلگرام",
                            style: TextStyle(fontFamily: "Yekan", fontSize: 9),
                          ),
                          Row(
                            children: [
                              const Text(
                                "Zabaner_Official   ",
                                style: TextStyle(
                                    fontFamily: "Yekan",
                                    fontSize: 9,
                                    color: Color(0xff5A5A5A)),
                              ),
                              Image.asset(
                                "assets/images/telegram.png",
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),

        // Version Text
        Padding(
          padding: EdgeInsets.only(bottom: Get.height / 50),
          child: const Text(
            "Version 5.2.1",
            style: TextStyle(
                fontFamily: "Arial", fontSize: 11, color: Color(0xffC2C2C2)),
          ),
        ),
      ],
    );
  }
}
