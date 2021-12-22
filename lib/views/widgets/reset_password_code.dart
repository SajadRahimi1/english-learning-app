import 'package:flutter/material.dart';
import 'package:zabaner/views/colors.dart';

class ResetPasswordCode extends StatelessWidget {
  const ResetPasswordCode({Key? key, required this.index, this.onChanged})
      : super(key: key);
  final int index;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 31, vertical: 3),
      child: TextFormField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontFamily: "Yekan"),
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty) {
            index == 3
                ? FocusScope.of(context).unfocus()
                : FocusScope.of(context).nextFocus();
          }
          onChanged!(value);
        },
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            fillColor: Color(0xffffffff),
            filled: true,
            counterText: "",
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: orange, width: 0.7),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: orange, width: 0.7),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    ));
  }
}
