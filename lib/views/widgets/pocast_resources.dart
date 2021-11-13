import 'package:flutter/material.dart';

class PocastResources extends StatelessWidget {
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
                width: MediaQuery.of(context).size.width / 17,
                height: MediaQuery.of(context).size.height / 30,
                child: Image.asset(
                  "assets/images/podcast.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const Text(
              "   پادکست ها",
              style: TextStyle(
                  fontFamily: "Yekan",
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5.4,
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
              itemBuilder: (context, index) => PocastListTile(),
              separatorBuilder: (context, index) => SizedBox(
                width: MediaQuery.of(context).size.width / 15,
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.grey[500],
          height: MediaQuery.of(context).size.height / 30,
        )
      ],
    );
  }
}

class PocastListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4.6,
          height: MediaQuery.of(context).size.height / 7.3,
          decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                  image: NetworkImage(
                    "https://images-na.ssl-images-amazon.com/images/I/51IkbV1cnGL.jpg",
                  ),
                  fit: BoxFit.fill)),
        ),
        const Text(
          "English Book",
          style: TextStyle(
              color: Color(0xffC2C2C2), fontSize: 10, fontFamily: "Yekan"),
        )
      ],
    );
  }
}
