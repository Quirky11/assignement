import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller_screen/repo_controller.dart';
import 'fileview_screen.dart';

class FileListingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RepoController repoController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Repository Files'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        if (repoController.currentRepoFiles.isEmpty) {
          return Center(
            child: Text(
              'No files available.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: repoController.currentRepoFiles.length,
          itemBuilder: (context, index) {
            final fileName = repoController.currentRepoFiles.keys.elementAt(index);
            final file = repoController.currentRepoFiles[fileName];
            final fileType = file['type'] ?? 'Unknown';

            IconData fileIcon;
            if (fileType.contains('image')) {
              fileIcon = Icons.image;
            } else if (fileType.contains('video')) {
              fileIcon = Icons.videocam;
            } else if (fileType.contains('text')) {
              fileIcon = Icons.article;
            } else {
              fileIcon = Icons.insert_drive_file;
            }

            return Card(
              margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                leading: Icon(fileIcon, color: Colors.blueAccent, size: 30),
                title: Text(fileName, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Type: $fileType'),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'view') {
                      // Use GetX to navigate to FileViewScreen
                      Get.to(() => FileViewScreen(fileName: fileName, fileType: fileType));
                    } else if (value == 'download') {
                      repoController.downloadFile(fileName,fileType);
                      Get.snackbar(
                        'Download',
                        '$fileName downloaded',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'view',
                      child: ListTile(
                        leading: Icon(Icons.visibility),
                        title: Text('View'),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'download',
                      child: ListTile(
                        leading: Icon(Icons.download),
                        title: Text('Download'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
