import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zabaner/controllers/book_detail_controller.dart';
import 'package:zabaner/models/urls.dart';
import 'package:zabaner/views/widgets/book_item_widget.dart';
import 'package:zabaner/views/widgets/serach_text_input.dart';
import 'package:zabaner/views/widgets/text_highlight.dart';

class BookScreen extends StatelessWidget {
  BookScreen({Key? key, required this.isGuest}) : super(key: key);
  final BookController controller = Get.put(BookController());
  final bool isGuest;
  @override
  Widget build(BuildContext context) {
    final String bookId = ModalRoute.of(context)?.settings.arguments as String;
    controller.getBookDetail(bookId, isGuest);
    final GetStorage _getStotage = GetStorage();
    GetStorage.init();
    controller.customeInit();
    print(controller.initialized);
    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                backgroundColor: const Color(0xffffffff),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
                  child: Column(children: [
                    // close this screen button
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, false);
                        controller.onClose();
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
                            onTap: () =>
                                Navigator.pushNamed(context, '/profile'),
                            child: CircleAvatar(
                              radius: Get.width / 18,
                              backgroundImage: NetworkImage(_getStotage
                                      .read('profile_image') ??
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Disc_Plain_cyan.svg/1200px-Disc_Plain_cyan.svg.png"),
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
                                  "کتاب های انگلیسی",
                                  style: TextStyle(
                                      fontFamily: "Yekan", fontSize: 16),
                                ),
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

                    Expanded(
                      child: controller.obx(
                        (state) => Column(
                          children: [
                            SizedBox(
                                width: Get.width,
                                height: Get.height / 4,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            SizedBox(
                                              width: Get.width / 2,
                                              height: Get.height / 22,
                                              child: Text(
                                                "   ${controller.bookDetail.title}",
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: "Yekan",
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Get.width / 1.7,
                                          child: Text(
                                            "\n" +
                                                controller.bookDetail.faTitle,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontFamily: "Yekan",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: Get.width / 3.2,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: NetworkImage(baseUrl +
                                                  controller
                                                      .bookDetail.imagePath),
                                              fit: BoxFit.fill)),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: Get.height / 50,
                            ),
                            Expanded(
                                child: ListView.builder(
                                    itemCount:
                                        controller.bookDetail.items.length,
                                    itemBuilder: (context, index) =>
                                        TextHighlight(
                                          faText: controller
                                              .bookDetail.items[index].faTitle,
                                          enText: controller
                                              .bookDetail.items[index].title,
                                          color: const Color(0xffffffff),
                                        )))
                          ],
                        ),
                      ),
                    )
                  ]),
                ))));
  }
}
