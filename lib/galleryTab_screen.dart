import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller_screen/gallery_controller.dart';
import 'fullscreenImageview_screen.dart';

class GalleryTab extends StatelessWidget {
  final GalleryController galleryController = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (galleryController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (galleryController.hasError.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 60),
              SizedBox(height: 8),
              Text('Failed to load images', style: TextStyle(fontSize: 18)),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: galleryController.fetchImages,
                icon: Icon(Icons.refresh),
                label: Text('Retry'),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: galleryController.fetchImages,
        child: GridView.builder(
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: galleryController.images.length,
          itemBuilder: (context, index) {
            final image = galleryController.images[index];
            return GestureDetector(
              onTap: () {
                // Getx state management for navigation
                Get.to(FullScreenImageView(imageUrl: image['urls']['regular']));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  image['urls']['thumb'],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
