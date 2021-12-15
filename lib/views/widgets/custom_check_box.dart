import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';

Widget customCheckBox(
    double width, double height, String text, void Function(bool) onData) {
  var checked = false.obs;
  checked.listen(onData);
  return InkWell(
    onTap: () => checked.value = !checked.value,
    child: Row(
      children: [
        Obx(() => Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                border: Border.all(color: orange),
                borderRadius: BorderRadius.circular(6),
                color: checked.value ? orange : Colors.white),
            child: checked.value
                ? const Icon(
                    Icons.done_rounded,
                    color: Color(0xffD9820A),
                    size: 16,
                  )
                : const SizedBox())),
        Text(
          text,
          style: const TextStyle(
              fontSize: 9, color: Color(0xff9F9F9F), fontFamily: "Yekan"),
        )
      ],
    ),
  );
}
