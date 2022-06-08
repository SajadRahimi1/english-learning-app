import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/models/resources_model.dart';
import 'package:zabaner/models/urls.dart';

class ChapterListScreen extends StatelessWidget {
  const ChapterListScreen({Key? key, required this.resource}) : super(key: key);
  final Resource resource;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: const Color(0xffffffff),
          appBar: AppBar(
              leadingWidth: Get.width,
              backgroundColor: const Color(0xffffffff),
              elevation: 0,
              leading: Padding(
                padding: EdgeInsets.only(right: Get.width / 40),
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: Colors.black,
                      ),
                      Text(
                        "بازگشت",
                        style: TextStyle(
                            fontFamily: "Yekan", color: Color(0xff000000)),
                      ),
                    ],
                  ),
                ),
              )),
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 40),
              child: Column(children: [
                // Top of screen
                SizedBox(
                  height: Get.height / 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // profile image
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, '/profile'),
                        child: CircleAvatar(
                          radius: Get.width / 18,
                          // backgroundImage: NetworkImage(_controller
                          //         .getProfileImage ??
                          //     "https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Solid_white.svg/2048px-Solid_white.svg.png"),
                        ),
                      ),

                      // Hello Text
                      const Text(
                        "داستان های کوتاه",
                        style: TextStyle(fontFamily: "Yekan", fontSize: 18),
                      ),

                      // Logo in top left
                      SizedBox.square(
                        // padding: EdgeInsets.only(left: Get.width / 25),
                        dimension: Get.width / 8,
                        // height: Get.height / 14,
                        child: Image.asset(
                          "assets/images/home_logo.png",
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),
                ),
                // information container
                Container(
                  width: Get.width,
                  height: Get.height / 6,
                  decoration: BoxDecoration(
                      color: Color(0xffDBDBDB),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(children: [
                    // image
                    Container(
                      width: Get.width / 3,
                      height: Get.height,
                      decoration: BoxDecoration(
                          color: Color(0xfff5400d),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(baseUrl + resource.imagePath),
                              fit: BoxFit.cover)),
                    ),

                    // empty space
                    SizedBox(
                      width: Get.width / 12,
                    ),

                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resource.title,
                          style: TextStyle(
                              fontFamily: "Yekan", fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            ImageIcon(AssetImage("assets/images/time.png"),
                                size: 22),
                            Text("\t\t" "زمان کل فصل : 24 دقیقه")
                          ],
                        ),
                        Row(
                          children: [
                            ImageIcon(AssetImage("assets/images/words.png"),
                                size: 22),
                            Text("\t\t" "تعداد کل کلمات : 817")
                          ],
                        )
                      ],
                    ))
                  ]),
                ),

                SizedBox(
                  height: 20,
                ),
                
                // chapter list
                Expanded(
                    child: ListView.builder(
                        itemCount: 8,
                        itemBuilder: (_, index) => Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 40),
                              width: Get.width,
                              height: Get.height / 14,
                              decoration: BoxDecoration(
                                  color: Color(0xffebebeb),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("فصل یکم"),
                                  Row(
                                    children: [
                                      ImageIcon(
                                          AssetImage("assets/images/time.png"),
                                          size: 22),
                                      Text("\t\t" "24 دقیقه")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ImageIcon(
                                          AssetImage("assets/images/words.png"),
                                          size: 22),
                                      Text("\t\t" "817 کلمه")
                                    ],
                                  ),
                                  CircleAvatar(
                                    backgroundColor: const Color(0xff7E7E7E),
                                    child: Center(
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )))
              ]))),
    );
  }
}
