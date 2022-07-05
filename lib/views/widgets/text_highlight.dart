import 'package:flutter/material.dart';

class TextHighlight extends StatelessWidget {
  const TextHighlight({
    Key? key,
    required this.enText,
    required this.faText,
    required this.enable,
    this.visibleEN = true,
    this.visibleFA = true,
  }) : super(key: key);
  final String enText, faText;
  final bool enable;
  final bool visibleEN, visibleFA;

  @override
  Widget build(BuildContext context) {
    return !visibleEN && !visibleFA
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
            child: Column(children: [
              Visibility(
                visible: visibleEN,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(enText,
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontWeight: enable ? FontWeight.bold : null)),
                ),
              ),
              Visibility(
                visible: visibleFA,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(faText,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontWeight: enable ? FontWeight.bold : null)),
                ),
              ),
            ]),
          );
  }
}
