import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileViewScreen extends StatelessWidget {
  final String fileName;
  final String fileType;

  // Use named parameters in the constructor
  FileViewScreen({required this.fileName, required this.fileType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fileName),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: fileType.contains('text')
            ? Text('Displaying text content for $fileName')
            : Text('Cannot display content of this file type.'),
      ),
    );
  }
}
