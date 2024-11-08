import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FullScreenImageController extends GetxController {
  var bookmarks = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadBookmarks();
  }

  // Load bookmarks from SharedPreferences
  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    bookmarks.value = prefs.getStringList('bookmarks') ?? [];
  }

  // Add an image to bookmarks
  Future<void> addBookmark(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    if (!bookmarks.contains(imageUrl)) {
      bookmarks.add(imageUrl);
      await prefs.setStringList('bookmarks', bookmarks);

      // Show snackbar using GetX
      Get.snackbar(
        'Success',
        'Added to Bookmarks',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    } else {
      // Show snackbar if already bookmarked
      Get.snackbar(
        'Info',
        'Already in Bookmarks',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    }
  }
}
