import 'package:flutter/material.dart';

class FileListingScreen extends StatelessWidget {
  final Map<String, dynamic> files;

  FileListingScreen({required this.files});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Repository Files'),
      backgroundColor: Colors.blueAccent,),
      body: ListView(
        children: files.keys.map((fileName) {
          final file = files[fileName];
          return ListTile(
            title: Text(fileName),
            subtitle: Text('Type: ${file['type']}'),
          );
        }).toList(),
      ),
    );
  }
}
