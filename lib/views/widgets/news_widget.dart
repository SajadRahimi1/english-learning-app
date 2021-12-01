import 'package:flutter/material.dart';
import 'package:zabaner/models/urls.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget(
      {Key? key,
      required this.description,
      required this.title,
      required this.imagePath})
      : super(key: key);
  final String title, description, imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 5.8,
      margin: EdgeInsetsDirectional.only(
        bottom: MediaQuery.of(context).size.height / 50,
      ),
      decoration: BoxDecoration(
          color: const Color(0xffDBDBDB),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icons
          SizedBox(
            width: MediaQuery.of(context).size.width / 6,
            height: MediaQuery.of(context).size.height / 7.7,
            child: Column(
              children: [
                const Icon(
                  Icons.bookmark_outline,
                  size: 35,
                  color: Color(0xff707070),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                const Icon(
                  Icons.share,
                  size: 30,
                  color: Color(0xff707070),
                )
              ],
            ),
          ),

          // title and describtion text
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.6,
              height: MediaQuery.of(context).size.height / 8,
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontFamily: "Arial", fontSize: 12),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 100,
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontFamily: "Arial",
                        fontSize: 10,
                        color: Color(0xff676767)),
                  ),
                ),
              ]),
            ),
          ),

          // Image
          Container(
            width: MediaQuery.of(context).size.width / 2.7,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage("$baseUrl$imagePath"),
                    fit: BoxFit.fill)),
          )
        ],
      ),
    );
  }
}
