import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  FullScreenImageView({required this.imageUrl});

  Future<void> _bookmarkImage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList('bookmarks') ?? [];

    // Only add if not already bookmarked
    if (!bookmarks.contains(imageUrl)) {
      bookmarks.add(imageUrl);
      await prefs.setStringList('bookmarks', bookmarks);

      // Show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added to Bookmarks'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Show snackbar if image is already bookmarked
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Already in Bookmarks'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent,actions: [
        IconButton(
          icon: Icon(Icons.bookmark),
          onPressed: () => _bookmarkImage(context), // Pass context here
        ),
      ]),
      body: PhotoView(
        imageProvider: NetworkImage(imageUrl),
      ),
    );
  }
}
