import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkController extends GetxController {
  var bookmarkedImages = <String>[].obs; //

  @override
  void onInit() {
    super.onInit();
    _loadBookmarks();
  }

  // Load bookmarks from SharedPreferences on initialization
  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    // Load the list of bookmarks, if available, or set to empty list
    bookmarkedImages.value = prefs.getStringList('bookmarks') ?? [];
  }

  // Add a new bookmark and save it to SharedPreferences
  Future<void> addBookmark(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    bookmarkedImages.add(imageUrl);  // Add the image to the list
    await prefs.setStringList('bookmarks', bookmarkedImages);  // Save to SharedPreferences
  }

  // Remove a bookmark and update SharedPreferences
  Future<void> removeBookmark(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    bookmarkedImages.remove(imageUrl);  // Remove the image from the list
    await prefs.setStringList('bookmarks', bookmarkedImages);  // Update SharedPreferences
  }
}
