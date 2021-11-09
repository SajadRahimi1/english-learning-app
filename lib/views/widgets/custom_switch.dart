import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSwitch extends StatelessWidget {
  var enable = false.obs;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => enable.value = !enable.value,
      child: Container(
          width: MediaQuery.of(context).size.width / 7,
          height: MediaQuery.of(context).size.height / 25,
          child: Obx(
            () => Stack(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 8,
                    height: MediaQuery.of(context).size.height / 42,
                    decoration: BoxDecoration(
                        color: enable.value
                            ? const Color(0xff3254F9)
                            : const Color(0xffB8B8B8),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                AnimatedAlign(
                  duration: const Duration(milliseconds: 250),
                  alignment: enable.value
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 37,
                    backgroundColor: enable.value
                        ? const Color(0xff050092)
                        : const Color(0xff000000),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
