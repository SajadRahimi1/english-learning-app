import 'package:flutter/material.dart';
import 'package:zabaner/models/urls.dart';

class ResourcesSearchWidget extends StatelessWidget {
  const ResourcesSearchWidget({
    Key? key,
    required this.type,
    required this.title,
    required this.id,
    required this.imagePath,
  }) : super(key: key);
  final String title, type, imagePath, id;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (type == "news") {
          Navigator.pushNamed(context, '/newsDetail', arguments: id);
        }
        if (type == "podcasts") {
          Navigator.pushNamed(context, '/podcast', arguments: id);
        }
        if (type == "books") {
          Navigator.pushNamed(context, '/bookScreen', arguments: id);
        }
        if (type == "videos") {
          Navigator.pushNamed(context, '/video', arguments: id);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5.8,
        margin: EdgeInsetsDirectional.only(
          bottom: MediaQuery.of(context).size.height / 50,
        ),
        decoration: BoxDecoration(
            color: const Color(0xffDBDBDB),
            borderRadius: BorderRadius.circular(18)),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // title and describtion text
            Padding(
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
                        style:
                            const TextStyle(fontFamily: "Arial", fontSize: 12),
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
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                      image: NetworkImage("$baseUrl$imagePath"),
                      fit: BoxFit.fill)),
            )
          ],
        ),
      ),
    );
  }
}
