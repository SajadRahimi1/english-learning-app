import 'package:flutter/material.dart';
import 'package:zabaner/models/resources_model.dart';
import 'package:zabaner/models/urls.dart';

class BookResources extends StatelessWidget {
  const BookResources({Key? key, required this.resource}) : super(key: key);
  final List<Resource> resource;
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
              "   کتاب های مبتدی",
              style: TextStyle(
                  fontFamily: "Yekan",
                  fontSize: 12,
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
              itemCount: 6,
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 25,
                right: MediaQuery.of(context).size.width / 25,
              ),
              reverse: true,
              itemBuilder: (context, index) => BookListTile(
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
          // indent: MediaQuery.of(context).size.width / 20,
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
      required this.id})
      : super(key: key);
  final String imagePath, title, id;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        '/bookScreen',
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 6,
            height: MediaQuery.of(context).size.height / 7.4,
            decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(
                      "$baseUrl$imagePath",
                    ),
                    fit: BoxFit.fill)),
          ),
          Text(
            title,
            style: const TextStyle(
                color: Color(0xffC2C2C2), fontSize: 10, fontFamily: "Yekan"),
          )
        ],
      ),
    );
  }
}
