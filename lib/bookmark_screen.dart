import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';  // Import the correct version
import 'controller_screen/bookmark_controller.dart'; // Import the controller

class BookmarkScreen extends StatelessWidget {
  final BookmarkController bookmarkController = Get.put(BookmarkController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarked Images'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        if (bookmarkController.bookmarkedImages.isEmpty) {
          return Center(child: Text('No bookmarked images.'));
        }

        return StaggeredGrid.count(
          crossAxisCount: 4, // Number of columns in the grid
          mainAxisSpacing: 8.0, // Vertical spacing between tiles
          crossAxisSpacing: 8.0, // Horizontal spacing between tiles
          children: List.generate(bookmarkController.bookmarkedImages.length, (index) {
            final imageUrl = bookmarkController.bookmarkedImages[index];

            return StaggeredGridTile.count(
              crossAxisCellCount: 2, // Each tile spans 2 columns
              mainAxisCellCount: index.isEven ? 2 : 1, // Alternating heights for staggered effect
              child: GestureDetector(
                onTap: () {
                  // Handle image click if needed
                },
                onLongPress: () {
                  // Remove image on long press
                  bookmarkController.removeBookmark(imageUrl);
                },
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.all(8),
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
