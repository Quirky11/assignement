import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller_screen/theme_controller.dart';
// Import the HomePage instead of the SplashScreen
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutterApp',
        themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blueAccent,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueAccent,
        ),
        home: HomeScreen(), // Set the HomePage as the initial screen instead of the splash screen
      );
    });
  }
}
