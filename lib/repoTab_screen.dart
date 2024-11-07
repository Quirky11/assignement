import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'fileListing_screen.dart';
import 'ownerInfo_screen.dart';

class RepoTab extends StatefulWidget {
  @override
  _RepoTabState createState() => _RepoTabState();
}

class _RepoTabState extends State<RepoTab> {
  List<dynamic> repos = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchRepos();
  }

  Future<void> fetchRepos() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });
    try {
      final response = await http.get(Uri.parse('https://api.github.com/gists/public'));
      if (response.statusCode == 200) {
        setState(() {
          repos = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
        });
      }
    } catch (error) {
      setState(() {
        hasError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.red, size: 60),
            SizedBox(height: 8),
            Text('Failed to load repositories', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: fetchRepos,
              icon: Icon(Icons.refresh),
              label: Text('Retry'),
            ),
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh: fetchRepos,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          itemCount: repos.length,
          itemBuilder: (context, index) {
            final repo = repos[index];
            return GestureDetector(
              onTap: () {
                // Navigate to the FileListingScreen with repository files
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FileListingScreen(files: repo['files']),
                  ),
                );
              },
              onLongPress: () {
                // Show owner information dialog
                showDialog(
                  context: context,
                  builder: (context) => OwnerInfoPopup(ownerInfo: repo['owner']),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(repo['owner']['avatar_url'] ?? ''),
                  ),
                  title: Text(
                    repo['description'] ?? 'No Description',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text(
                        'Created: ${repo['created_at']}',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Updated: ${repo['updated_at']}',
                        style: TextStyle(fontSize: 12),
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
  }
}
