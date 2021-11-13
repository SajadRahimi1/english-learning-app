import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchTextInput extends StatelessWidget {
  const SearchTextInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
          fontFamily: "Yekan", fontSize: 14, color: Color(0xffffffff)),
      textAlignVertical: TextAlignVertical.top,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        fillColor: const Color(0xffDBDBDB),
        filled: true,
        contentPadding: EdgeInsets.zero,
        hintText: "کلمه مورد نظر جهت جستجو را وارد کنید",
        hintStyle: const TextStyle(
            fontFamily: "Yekan", fontSize: 10, color: Color(0xffffffff)),
        prefixIconConstraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 8),
        prefixIcon: SizedBox(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 13, top: 4, bottom: 4, right: 5),
            child: Image.asset(
              "assets/images/search.png",
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none),
      ),
    );
  }
}
