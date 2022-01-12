import 'package:flutter/material.dart';
import 'package:zabaner/views/colors.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput(
      {Key? key,
      required this.hintText,
      required this.iconPath,
      required this.error,
      this.keyboardType,
      this.password = false,
      this.onChanged})
      : super(key: key);
  final String hintText, iconPath;
  final void Function(String)? onChanged;
  final bool error;
  final bool password;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onChanged,
        style: const TextStyle(fontFamily: "Yekan", fontSize: 17),
        textAlignVertical: TextAlignVertical.top,
        keyboardType: keyboardType,
        obscureText: password,
        obscuringCharacter: '*',
        decoration: InputDecoration(
            filled: true,
            hintText: hintText,
            contentPadding: EdgeInsets.zero,
            hintStyle: const TextStyle(
                fontSize: 10, fontFamily: "Yekan", color: Color(0xffb0b0b0)),
            hintTextDirection: TextDirection.rtl,
            fillColor: const Color(0xffffffff),
            prefixIconConstraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 8),
            prefixIcon: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 13, top: 4, bottom: 4, right: 13),
                child: Image.asset(
                  "assets/images/$iconPath",
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: error ? const Color(0xffff0000) : orange,
                    width: 0.8),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: error ? const Color(0xffff0000) : orange,
                    width: 0.8),
                borderRadius: const BorderRadius.all(Radius.circular(8)))));
  }
}
