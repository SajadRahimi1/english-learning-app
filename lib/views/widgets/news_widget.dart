import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key? key, required this.description, required this.title})
      : super(key: key);
  final String title, description;
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
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.bookmark_outline,
                  size: 35,
                  color: Color(0xff707070),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
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
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.25,
            height: MediaQuery.of(context).size.height,
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontFamily: "Arial", fontSize: 12),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontFamily: "Arial",
                        fontSize: 10,
                        color: Color(0xff676767)),
                  ),
                ]),
          ),

          // Image
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://www.vuelio.com/uk/wp-content/uploads/2019/02/Breaking-News.jpg"),
                    fit: BoxFit.fill)),
          )
        ],
      ),
    );
  }
}
