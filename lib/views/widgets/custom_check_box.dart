import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';

Widget CustomCheckBox(double width, double height) {
  var checked = false.obs;

  return InkWell(
    onTap: () => checked.value = !checked.value,
    child: Row(
      children: [
        Obx(() => Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                border: Border.all(color: orange),
                borderRadius: BorderRadius.circular(7),
                color: checked.value ? orange : Colors.white),
            child: checked.value
                ? const Icon(
                    Icons.done_rounded,
                    color: Color(0xffD9820A),
                    size: 16,
                  )
                : const SizedBox())),
        const Text(
          "   ذخیره اطلاعات ورود",
          style: TextStyle(
              fontSize: 10, color: Color(0xff9F9F9F), fontFamily: "Yekan"),
        )
      ],
    ),
  );
}
