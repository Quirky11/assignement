import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OwnerInfoPopup extends StatelessWidget {
  final Map<String, dynamic> ownerInfo;

  OwnerInfoPopup({required this.ownerInfo});

  @override
  Widget build(BuildContext context) {
    // Check if the theme is dark or light
    bool isDarkMode = Get.isDarkMode;

    return AlertDialog(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      title: Text(
        ownerInfo['login'],
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(ownerInfo['avatar_url']),
          Text(
            'ID: ${ownerInfo['id']}',
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          ),
          GestureDetector(
            onTap: () async {
              final url = Uri.parse(ownerInfo['html_url']);
              if (await launchUrl(url, mode: LaunchMode.externalApplication)) {
                // Successfully launched
              } else {
                // Handle the error
                throw 'Could not launch $url';
              }
            },
            child: Text(
              'URL: ${ownerInfo['html_url']}',
              style: TextStyle(
                color: Colors.blueAccent,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'Close',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }
}
