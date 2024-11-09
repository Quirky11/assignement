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
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            itemCount: bookmarkController.bookmarkedImages.length,
            itemBuilder: (context, index) {
              final imageUrl = bookmarkController.bookmarkedImages[index];

              return GestureDetector(
                onTap: () {
                  // any functionalities can be added for on Tap such as Download Image
                },
                onLongPress: () {
                  // Remove image from bookmark  on long press
                  bookmarkController.removeBookmark(imageUrl);
                },
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.all(4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      height: (index.isEven ? 200.0 : 300.0), // Staggered view effect
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
