import 'package:flutter/material.dart';
import 'package:zabaner/views/colors.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  final String time;
  final String type;
  const MessageWidget(
      {Key? key, required this.text, required this.time, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          type == "question" ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 1.2,
          minWidth: MediaQuery.of(context).size.width / 6.5,
        ),
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
                color: type == "question" ? orange : Colors.cyan,
                borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5) +
                  (type == "question"
                      ? EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 60, top: 5)
                      : EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 60,
                          top: 5)),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(
                  text,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontFamily: "Yekan",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xff000000)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    time,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff000000),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
