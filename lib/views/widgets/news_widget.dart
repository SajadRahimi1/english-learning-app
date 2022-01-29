import 'package:flutter/material.dart';
import 'package:zabaner/models/urls.dart';
import 'package:get/get.dart';
import 'package:zabaner/views/screens/news_detail_screen.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    Key? key,
    required this.description,
    required this.title,
    required this.id,
    required this.imagePath,
    required this.bookmark,
    required this.isGuest,
  }) : super(key: key);
  final String title, description, imagePath, id;
  final bool bookmark, isGuest;
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
          borderRadius: BorderRadius.circular(18)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // title and describtion text
          InkWell(
              onTap: () {
                // Navigator.pushNamed(context, '/newsDetail', arguments: id);
                Get.to(NewsDetailScreen(isGuest: isGuest), arguments: id);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2.6,
                  height: MediaQuery.of(context).size.height / 8,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontFamily: "Arial",
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 100,
                          ),
                          child: Text(
                            title,
                            style: const TextStyle(
                                fontFamily: "Arial", color: Color(0xff676767)),
                          ),
                        ),
                      ]),
                ),
              )),

          // Image
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/newsDetail', arguments: id);
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2.7,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    image: DecorationImage(
                        image: NetworkImage("$baseUrl$imagePath"),
                        fit: BoxFit.fill)),
              ))
        ],
      ),
    );
  }
}
