import 'package:flutter/material.dart';

class SearchTextInput extends StatelessWidget {
  const SearchTextInput({Key? key, this.onClick, this.onFieldSubmitted})
      : super(key: key);
  final Function()? onClick;
  final Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        // onChanged: onChanged,
        onTap: onClick,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: TextInputAction.search,
        style: const TextStyle(fontFamily: "Yekan", fontSize: 14),
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            filled: true,
            hintText: "کلمه مورد نظر جهت جستجو را وارد کنید",
            contentPadding: EdgeInsets.zero,
            hintStyle: const TextStyle(
                fontFamily: "Yekan", fontSize: 12, color: Color(0xffffffff)),
            hintTextDirection: TextDirection.rtl,
            fillColor: const Color(0xffDBDBDB),
            prefixIconConstraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 8),
            prefixIcon: Padding(
              padding:
                  const EdgeInsets.only(left: 13, top: 4, bottom: 4, right: 13),
              child: Image.asset(
                "assets/images/search.png",
                fit: BoxFit.scaleDown,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(17))),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(17)))));
  }
}
