import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/views/screens/splash_screen.dart';
import 'package:cron/cron.dart';

void main() async {
  var cron = Cron();

  cron.schedule(Schedule.parse('*/1 * * * *'), () async {
    // run daily on 10:00
    // GetConnect getConnect = GetConnect();
    // var req = await getConnect.get("http://192.168.1.8:3000");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
