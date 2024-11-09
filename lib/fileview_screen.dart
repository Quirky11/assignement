import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileViewScreen extends StatelessWidget {
  final String fileName;
  final String fileType;
  FileViewScreen({required this.fileName, required this.fileType});

  @override
  Widget build(BuildContext context) {
    // Determining the background color and text color based on the current theme
    Color backgroundColor = Get.isDarkMode ? Colors.black : Colors.white;
    Color textColor = Get.isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(fileName),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: fileType.contains('text')
            ? Text(
          'Displaying text content for $fileName',
          style: TextStyle(color: textColor),
        )
            : Text(
          'Cannot display content of this file type.',
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
