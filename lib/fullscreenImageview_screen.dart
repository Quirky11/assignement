import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:get/get.dart';
import 'controller_screen/fullscreen_controller.dart';

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  FullScreenImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FullScreenImageController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(imageUrl),
            backgroundDecoration: BoxDecoration(
              color: isDarkMode ? Colors.black : Colors.white,
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: Icon(
                Icons.bookmark,
                color: isDarkMode ? Colors.white : Colors.black, // Change icon color based on theme
              ),
              onPressed: () => controller.addBookmark(imageUrl), // Using GetX to add bookmark
            ),
          ),
        ],
      ),
    );
  }
}
