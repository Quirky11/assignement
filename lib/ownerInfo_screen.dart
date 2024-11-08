import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerInfoPopup extends StatelessWidget {
  final Map<String, dynamic> ownerInfo;

  OwnerInfoPopup({required this.ownerInfo});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(ownerInfo['login']),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(ownerInfo['avatar_url']),
          Text('ID: ${ownerInfo['id']}'),
          Text('URL: ${ownerInfo['html_url']}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(), // Using GetX to close the dialog
          child: Text('Close'),
        ),
      ],
    );
  }
}
