import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabaner/views/screens/splash_screen.dart';
import 'package:cron/cron.dart';

void main() {
  // var cron = Cron();
  // cron.schedule(Schedule.parse('30 23 * * *'), () async {
  //     // run daily on 23:30
  // });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
