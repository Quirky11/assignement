import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:get/get.dart';
import 'controller_screen/fullscreen_controller.dart';

class FullScreenImageView extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;

  FullScreenImageView({required this.imageUrls, this.initialIndex = 0, required imageUrl});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FullScreenImageController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final PageController pageController = PageController(initialPage: initialIndex);

    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = imageUrls[index];

          return Stack(
            children: [
              PhotoView(
                imageProvider: NetworkImage(imageUrl),
                backgroundDecoration: BoxDecoration(
                  color: isDarkMode ? Colors.black : Colors.white,
                ),
                loadingBuilder: (context, event) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(Icons.broken_image, color: Colors.grey, size: 60),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.bookmark,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  onPressed: () => controller.addBookmark(imageUrl),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
