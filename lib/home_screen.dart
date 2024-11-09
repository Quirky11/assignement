import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller_screen/theme_controller.dart';
import 'controller_screen/repo_controller.dart';
import 'repoTab_screen.dart';
import 'galleryTab_screen.dart';
import 'bookmark_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  Future<void> saveData(String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }

  Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> clearCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ThemeController themeController = Get.find();
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Get.put(RepoController()); // Initialize RepoController
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(
            _currentIndex == 0 ? 'Repositories' : 'Gallery',
            style: TextStyle(
              color: themeController.isDarkMode.value ? Colors.white : Colors
                  .black,
            ),
          );
        }),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Obx(() =>
                Icon(
                  themeController.isDarkMode.value ? Icons.brightness_7 : Icons
                      .brightness_2,
                )),
            onPressed: themeController.toggleTheme,
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              Get.to(() => BookmarkScreen());
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          RepoTab(), // RepoTab observes theme changes too
          GalleryTab(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          backgroundColor: themeController.isDarkMode.value
              ? Colors.black
              : Colors.white,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index);
            });
          },
          selectedItemColor: Colors.blueAccent,
          // Selected item color
          unselectedItemColor: Colors.grey,
          // Unselected item color
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Repos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: 'Gallery',
            ),
          ],
        );
      }),
    );
  }
}
