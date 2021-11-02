import 'package:flutter/material.dart';
import 'package:zabaner/views/colors.dart';

class CustomTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
            filled: true,
            hintText: "نام کاربری",
            contentPadding: const EdgeInsets.all(0),
            hintStyle: const TextStyle(fontSize: 10, fontFamily: "Yekan"),
            hintTextDirection: TextDirection.rtl,
            fillColor: const Color(0xffffffff),
            prefixIcon: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 13, top: 4, bottom: 4, right: 13),
                child: Image.asset(
                  "assets/images/username.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: orange, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: orange, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(8)))));
  }
}
