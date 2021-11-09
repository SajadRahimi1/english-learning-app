import 'package:flutter/material.dart';

class CustomTextInputProfile extends StatelessWidget {
  const CustomTextInputProfile(
      {Key? key,
      required this.hintText,
      required this.iconPath,
      this.isEnabled = true,
      this.onChanged})
      : super(key: key);
  final String hintText, iconPath;
  final void Function(String)? onChanged;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: isEnabled,
        onChanged: onChanged,
        style: const TextStyle(fontFamily: "Yekan", fontSize: 14),
        textAlignVertical: TextAlignVertical.top,
        decoration: isEnabled
            ? InputDecoration(
                filled: true,
                hintText: hintText,
                contentPadding: EdgeInsets.zero,
                hintStyle: const TextStyle(
                    fontSize: 10,
                    fontFamily: "Yekan",
                    color: Color(0xffb0b0b0)),
                hintTextDirection: TextDirection.rtl,
                fillColor: const Color(0xffffffff),
                prefixIconConstraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 8),
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
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8))))
            : InputDecoration(
                filled: true,
                hintText: hintText,
                contentPadding: EdgeInsets.zero,
                hintStyle: const TextStyle(
                    fontSize: 10,
                    fontFamily: "Yekan",
                    color: Color(0xffb0b0b0)),
                hintTextDirection: TextDirection.rtl,
                fillColor: const Color(0xffE8E8E8),
                prefixIconConstraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 8),
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
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ));
  }
}
