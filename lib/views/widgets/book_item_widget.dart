import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  const BookItem({Key? key, required this.enText, required this.faText})
      : super(key: key);
  final String enText;
  final String faText;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text(
          enText,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text(
          faText,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
      )
    ]);
  }
}
