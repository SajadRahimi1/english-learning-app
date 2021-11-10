import 'package:flutter/material.dart';

Widget barChart(
    {required double width,
    required double height,
    required String topText,
    required String bottomText,
    required Color color}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text(
        topText,
        style: const TextStyle(
            fontFamily: "Yekan", fontSize: 10, color: Color(0xff686868)),
      ),
      Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10))),
      Text(
        bottomText,
        style: const TextStyle(
            fontFamily: "Yekan", fontSize: 10, color: Colors.grey),
      ),
    ],
  );
}
