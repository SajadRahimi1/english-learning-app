import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/views/widgets/custom_switch.dart';

class SettingCard extends StatelessWidget {
  final String title;

  const SettingCard({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffF9F9F9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
          width: Get.width,
          height: Get.height / 20,
          child: Container(
            width: Get.width,
            height: Get.height / 18,
            margin: EdgeInsets.symmetric(
                horizontal: Get.width / 20, vertical: Get.height / 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontFamily: "Yekan", fontSize: 9),
                ),
                CustomSwitch()
              ],
            ),
          )),
    );
  }
}
