import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class GalleryController extends GetxController {
  var images = <dynamic>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchImages(); // Fetch images on initialization
  }

  Future<void> fetchImages() async {
    isLoading.value = true;
    hasError.value = false;

    try {
      final prefs = await SharedPreferences.getInstance();
      String? cachedImages = prefs.getString('images_cache');
      int? cacheTime = prefs.getInt('images_cache_time');
      int currentTime = DateTime.now().millisecondsSinceEpoch;

      // Check cache if it exists and is less than 1 hour old (3600000 ms)
      if (cachedImages != null && cacheTime != null && currentTime - cacheTime < 3600000) {
        // Load images from cache
        images.value = json.decode(cachedImages);
      } else {
        // Fetch images from API
        final response = await http.get(Uri.parse('https://api.unsplash.com/photos?client_id=rh9Frtt0EPKYZOD0TkSq-DonWo0sl-Od90uFHEW2j60'));
        if (response.statusCode == 200) {
          images.value = json.decode(response.body);
          // Update cache with new data and set current time
          prefs.setString('images_cache', response.body);
          prefs.setInt('images_cache_time', currentTime);
        } else {
          hasError.value = true;
        }
      }
    } catch (error) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
