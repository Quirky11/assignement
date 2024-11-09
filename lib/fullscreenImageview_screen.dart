import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:get/get.dart';
import 'controller_screen/fullscreen_controller.dart';

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  FullScreenImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    // Get the controller instance
    final controller = Get.put(FullScreenImageController());

    // Detect the brightness to choose background color
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(imageUrl),
            backgroundDecoration: BoxDecoration(
              color: isDarkMode ? Colors.black : Colors.white, // Set background based on theme
            ),
          ),
          Positioned(
            top: 20, // Adjust the position if needed
            right: 20,
            child: IconButton(
              icon: Icon(
                Icons.bookmark,
                color: isDarkMode ? Colors.white : Colors.black, // Change icon color based on theme
              ),
              onPressed: () => controller.addBookmark(imageUrl), // Use GetX to add bookmark
            ),
          ),
        ],
      ),
    );
  }
}
