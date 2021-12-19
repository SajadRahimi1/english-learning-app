import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/controllers/book_detail_controller.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/widgets/serach_text_input.dart';

class BookScreen extends StatelessWidget {
  BookScreen({Key? key}) : super(key: key);
  final BookController _controller = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    final String bookId = ModalRoute.of(context)?.settings.arguments as String;
    _controller.getBookDetail(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWFiMjdmOGY4OGEwYjEyZjUwMzBiMTUiLCJpYXQiOjE2Mzg3NzIzODksImV4cCI6MTYzODgwODM4OX0.G58g83TMQPC2-GtdparASJu9Ys9n-F8e8aXGJy4ZsnI",
        bookId);
    final GetStorage _getStotage = GetStorage();
    GetStorage.init();
    _controller.onInit();

    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                backgroundColor: const Color(0xffffffff),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
                  child: ListView(children: [
                    // close this screen button
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, false);
                        _controller.onClose();
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.arrow_back,
                            size: 18,
                          ),
                          Text("  بازگشت",
                              style:
                                  TextStyle(fontFamily: "Yekan", fontSize: 12)),
                        ],
                      ),
                    ),

                    // Top of screen
                    SizedBox(
                      height: Get.height / 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // profile image
                          InkWell(
                            onTap: ()=>Navigator.pushNamed(context, '/profile'),
                            child: CircleAvatar(
                              radius: Get.width / 18,
                              backgroundImage:
                                  NetworkImage(_getStotage.read('profile_image')),
                            ),
                          ),

                          // Hello Text
                          SizedBox(
                            width: Get.width / 1.72,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "سلام سامان!",
                                  style: TextStyle(
                                      fontFamily: "Yekan", fontSize: 16),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "اخبار متنوع به زبان انگلیسی",
                                  style: TextStyle(
                                      fontFamily: "Yekan",
                                      fontSize: 8,
                                      color: Color(0xff919191)),
                                )
                              ],
                            ),
                          ),

                          // Logo in top left
                          Container(
                            padding: EdgeInsets.only(left: Get.width / 25),
                            width: Get.width / 5,
                            height: Get.height / 14,
                            child: Image.asset(
                              "assets/images/home_logo.png",
                              fit: BoxFit.fill,
                            ),
                          )
                        ],
                      ),
                    ),

                    // Search Text Input
                    SizedBox(
                        width: Get.width,
                        height: Get.height / 22,
                        child: const SearchTextInput()),

                    // Space between search text input and body
                    SizedBox(
                      height: Get.height / 30,
                    ),

                    _controller.obx(
                      (state) => SizedBox(
                          width: Get.width,
                          height: Get.height / 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width / 10,
                                        height: Get.height / 22,
                                        child: Image.asset(
                                          "assets/images/bookr.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: Get.width / 2,
                                            height: Get.height / 22,
                                            child: Text(
                                              "   ${_controller.bookDetail.title}",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontFamily: "Yekan",
                                                  fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width / 2,
                                            height: Get.height / 22,
                                            child: const Text(
                                              "     Dictionary of English",
                                              style: TextStyle(
                                                  fontFamily: "Yekan",
                                                  color: Color(0xffC2C2C2),
                                                  fontSize: 10),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: Get.width / 1.7,
                                    child: Text(
                                      _controller.bookDetail.faTitle,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: "Yekan",
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: Get.height / 50),
                                    child: const Text(
                                      "راهنمای مبتدیان جهت مکالمات روزانه",
                                      style: TextStyle(
                                          fontFamily: "Yekan",
                                          fontSize: 10,
                                          color: Color(0xffC2C2C2)),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                width: Get.width / 3.2,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(baseUrl +
                                            _controller.bookDetail.imagePath),
                                        fit: BoxFit.fill)),
                              )
                            ],
                          )),
                    )
                  ]),
                ))));
  }
}
