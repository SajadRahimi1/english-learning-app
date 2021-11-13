import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  final String image, title;
  final void Function()? onTap;
  const ProfileTab(
      {Key? key, required this.image, this.onTap, required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab Icon
        InkWell(
          onTap: onTap,
          child: Container(
            width: MediaQuery.of(context).size.width / 8.5,
            height: MediaQuery.of(context).size.height / 17,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 0.5, color: const Color(0xff707070))),
            child: Image.asset(
              "assets/images/$image",
              fit: BoxFit.fill,
            ),
          ),
        ),

        // Tab text
        Text(
          title,
          style: const TextStyle(
              fontFamily: "Yekan", fontSize: 10, color: Color(0xff5A5A5A)),
        )
      ],
    );
  }
}
