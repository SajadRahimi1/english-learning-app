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
    return Card(
      color: color,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
        child: Column(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(enText,
                textAlign: TextAlign.left, textDirection: TextDirection.ltr),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(faText,
                textAlign: TextAlign.right, textDirection: TextDirection.rtl),
          ),
        ]),
      ),
    );
  }
}
