import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller_screen/repo_controller.dart';
import 'controller_screen/theme_controller.dart';
import 'fileListing_screen.dart';
import 'ownerInfo_screen.dart';
import 'package:intl/intl.dart';

class RepoTab extends StatelessWidget {
  final RepoController repoController = Get.find();
  final ThemeController themeController = Get.find(); // Access ThemeController

  String formatDate(String date) {
    final DateTime dateTime = DateTime.parse(date);
    return DateFormat('MMM dd, yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: themeController.isDarkMode.value ? Colors.black : Colors.white,
        body: repoController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
          onRefresh: repoController.fetchRepos,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            itemCount: repoController.repos.length,
            itemBuilder: (context, index) {
              final repo = repoController.repos[index];
              final createdDate = formatDate(repo['created_at']);
              final updatedDate = formatDate(repo['updated_at']);
              final commentCount = repo['comments'] ?? 0;

              return GestureDetector(
                onTap: () {
                  repoController.setRepoFiles(repo['files']);
                  Get.to(() => FileListingScreen());
                },
                onLongPress: () {
                  Get.dialog(OwnerInfoPopup(ownerInfo: repo['owner']));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: themeController.isDarkMode.value ? Colors.grey[800] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(repo['owner']['avatar_url'] ?? ''),
                    ),
                    title: Text(
                      repo['description'] ?? 'No Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: themeController.isDarkMode.value ? Colors.white : Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Created: $createdDate',
                          style: TextStyle(
                            color: themeController.isDarkMode.value ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        Text(
                          'Updated: $updatedDate',
                          style: TextStyle(
                            color: themeController.isDarkMode.value ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        Text(
                          'Comments: $commentCount',
                          style: TextStyle(
                            color: themeController.isDarkMode.value ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.chevron_right, color: Colors.grey),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
