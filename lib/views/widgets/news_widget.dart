import 'package:flutter/material.dart';
import 'package:zabaner/models/urls.dart';
import 'package:get/get.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget(
      {Key? key,
      required this.description,
      required this.title,
      required this.id,
      required this.imagePath,
      required this.bookmark,
      this.onBookmarkTap})
      : super(key: key);
  final String title, description, imagePath, id;
  final bool bookmark;
  final void Function()? onBookmarkTap;
  @override
  Widget build(BuildContext context) {
    var rxBookmark = RxBool(bookmark);
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icons
          SizedBox(
            width: MediaQuery.of(context).size.width / 6,
            height: MediaQuery.of(context).size.height / 7.7,
            child: Column(
              children: [
                InkWell(
                    onTap: () {
                      rxBookmark.toggle();
                      onBookmarkTap!();
                    },
                    child: Obx(() => rxBookmark.value
                        ? Icon(
                            Icons.bookmark,
                            size: 35,
                            color: Color(0xff707070),
                          )
                        : Icon(
                            Icons.bookmark_outline,
                            size: 35,
                            color: Color(0xff707070),
                          ))),
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
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/newsDetail', arguments: id);
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
                              fontFamily: "Arial", fontSize: 12),
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
