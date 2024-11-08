import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller_screen/theme_controller.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Initialize the theme controller here
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Use the current theme based on the isDarkMode value
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutterApp',
        themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light, // Choose dark or light mode based on isDarkMode
        theme: ThemeData(
          brightness: Brightness.light, // Light mode settings
          primaryColor: Colors.blueAccent,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark, // Dark mode settings
          primaryColor: Colors.blueAccent,
        ),
        home: HomeScreen(), // Home screen as the entry point
      );
    });
  }
}
