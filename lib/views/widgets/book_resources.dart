import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/models/resources_model.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/screens/book_screen.dart';
import 'package:zabaner/views/screens/books_list_screen.dart';

class BookResources extends StatelessWidget {
  const BookResources({Key? key, required this.resource, required this.isGuest})
      : super(key: key);
  final List<Resource> resource;

  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width / 30,
                bottom: MediaQuery.of(context).size.height / 66,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 12,
                height: MediaQuery.of(context).size.height / 30,
                child: Image.asset(
                  "assets/images/bookr.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const Text(
              "   داستان های کوتاه",
              style: TextStyle(
                  fontFamily: "Yekan",
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5.3,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: resource.length,
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 25,
                right: MediaQuery.of(context).size.width / 25,
              ),
              reverse: true,
              itemBuilder: (context, index) => BookListTile(
                  isGuest: isGuest,
                  imagePath: resource[index].imagePath,
                  title: resource[index].title,
                  id: resource[index].id),
              separatorBuilder: (context, index) => SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
            ),
          ),
        ),
        Divider(
          color: const Color(0xffDBDBDB),
          height: MediaQuery.of(context).size.height / 30,
          endIndent: MediaQuery.of(context).size.width / 20,
        )
      ],
    );
  }
}

class BookListTile extends StatelessWidget {
  const BookListTile(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.isGuest,
      required this.id})
      : super(key: key);
  final String imagePath, title, id;
  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => Get.to(() => BookScreen(isGuest: isGuest), arguments: id),
      onTap: () => Get.to(() => BooksListScreen()),
      // onTap: () => Navigator.pushNamed(context, '/bookScreen', arguments: id),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // image
          Container(
            width: MediaQuery.of(context).size.width / 5.3,
            height: MediaQuery.of(context).size.height / 7.6,
            decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                    image: NetworkImage(
                      "$baseUrl$imagePath",
                    ),
                    fit: BoxFit.fill)),
          ),

          // title
          SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color(0xff000000), fontSize: 12, fontFamily: "Yekan"),
            ),
          )
        ],
      ),
    );
  }
}
