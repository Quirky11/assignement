import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class RepoController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;
  RxList repos = [].obs; // List to store repositories
  RxMap<String, dynamic> files = RxMap<String, dynamic>(); // Map to store files for the selected repo

  @override
  void onInit() {
    super.onInit();
    fetchRepos(); // Fetch repositories on controller initialization
  }

  // Fetch repositories from API or cache
  Future<void> fetchRepos() async {
    isLoading.value = true;
    hasError.value = false;

    try {
      final prefs = await SharedPreferences.getInstance();
      String? cachedRepos = prefs.getString('repos_cache');
      int? cacheTime = prefs.getInt('repos_cache_time'); // Retrieve cache time
      int currentTime = DateTime.now().millisecondsSinceEpoch;

      // If cache is available and less than 1 hour old, load it
      if (cachedRepos != null && cacheTime != null && currentTime - cacheTime < 3600000) {
        repos.value = List<Map<String, dynamic>>.from(jsonDecode(cachedRepos));
      } else {
        // Fetch from API if cache is outdated or not available
        final response = await http.get(Uri.parse('https://api.github.com/gists/public'));
        if (response.statusCode == 200) {
          repos.value = List<Map<String, dynamic>>.from(jsonDecode(response.body));
          prefs.setString('repos_cache', response.body);
          prefs.setInt('repos_cache_time', currentTime); // Save current time as cache time
        } else {
          hasError.value = true;
        }
      }
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }


  // Fetch files for a specific repository
  Future<void> fetchFilesForRepo(String repoId) async {
    isLoading.value = true;
    hasError.value = false;

    try {
      final response = await http.get(Uri.parse('https://api.github.com/gists/$repoId'));
      if (response.statusCode == 200) {
        final repoData = jsonDecode(response.body);
        files.value = Map<String, dynamic>.from(repoData['files']);
      } else {
        hasError.value = true;
      }
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  // Set the files for the selected repository
  void setRepoFiles(Map<String, dynamic> repoFiles) {
    files.value = repoFiles;
  }

  // Getter for current repo files
  Map<String, dynamic> get currentRepoFiles => files;

  // Method to download a file
  Future<void> downloadFile(String url, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);

      // Check if the file already exists
      if (await file.exists()) {
        Get.snackbar('File Exists', 'File already downloaded to $filePath');
        return;
      }

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        Get.snackbar('Download Complete', 'File downloaded to $filePath');
      } else {
        Get.snackbar('Error', 'Failed to download file');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while downloading the file');
    }
  }
}
