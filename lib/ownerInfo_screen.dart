import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OwnerInfoPopup extends StatelessWidget {
  final Map<String, dynamic> ownerInfo;

  OwnerInfoPopup({required this.ownerInfo});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.isDarkMode;
    final backgroundColor = isDarkMode ? Colors.grey[900] : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: backgroundColor,
      title: Center(
        child: Text(
          ownerInfo['login'],
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(ownerInfo['avatar_url']),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(height: 12),
          Divider(color: isDarkMode ? Colors.grey[700] : Colors.grey[300]),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'ID: ${ownerInfo['id']}',
              style: TextStyle(color: textColor),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () async {
              final url = Uri.parse(ownerInfo['html_url']);
              if (await launchUrl(url, mode: LaunchMode.externalApplication)) {
                // Launches the URL
              } else {
                throw 'Could not launch $url';
              }
            },
            icon: Icon(Icons.link, color: Colors.white),
            label: Text(
              'View Profile',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
