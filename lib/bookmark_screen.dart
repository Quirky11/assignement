import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'controller_screen/bookmark_controller.dart';

class BookmarkScreen extends StatelessWidget {
  final BookmarkController bookmarkController = Get.put(BookmarkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Bookmarked Images'),
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (bookmarkController.bookmarkedImages.isEmpty) {
          return Center(child: Text('No bookmarked images.'));
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: MasonryGridView.count(
            crossAxisCount: 2, // Number of columns in the grid
            mainAxisSpacing: 8.0, // Vertical spacing between tiles
            crossAxisSpacing: 8.0, // Horizontal spacing between tiles
            itemCount: bookmarkController.bookmarkedImages.length,
            itemBuilder: (context, index) {
              final imageUrl = bookmarkController.bookmarkedImages[index];

              return GestureDetector(
                onTap: () {
                  // Handle image click if needed
                },
                onLongPress: () {
                  // Remove image on long press
                  bookmarkController.removeBookmark(imageUrl);
                },
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.all(4), // Adjusted margin for better spacing
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      height: (index.isEven ? 200.0 : 300.0), // Alternate heights for staggered effect
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
