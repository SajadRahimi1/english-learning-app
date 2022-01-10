import 'package:flutter/material.dart';

class TextHighlight extends StatelessWidget {
  const TextHighlight(
      {Key? key,
      required this.enText,
      required this.faText,
      required this.color})
      : super(key: key);
  final String enText, faText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(children: [
        Text(enText,
            textAlign: TextAlign.left, textDirection: TextDirection.ltr),
        Text(
          faText,
        ),
      ]),
    );
  }
}
