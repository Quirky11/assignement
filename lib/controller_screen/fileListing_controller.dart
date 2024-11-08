import 'package:get/get.dart';

class FileListingController extends GetxController {
  var files = <String, dynamic>{}.obs;

  // Method to update the files
  void setFiles(Map<String, dynamic> newFiles) {
    files.value = newFiles;
  }
}
