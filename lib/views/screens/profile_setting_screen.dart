import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onLongPressEnd: (details) {
            print("ended");
          },
          child: Container(
            color: Colors.cyan,
            width: 50,
            height: 30,
          ),
        ),
        InkWell(
            onHover: (value) {
              print("Hover");
            },
            child: Container(
              color: Colors.red,
              width: 10,
              height: 50,
            ))
      ],
    );
  }
}
