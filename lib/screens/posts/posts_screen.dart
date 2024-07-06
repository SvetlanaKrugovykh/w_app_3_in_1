import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../localization/localization_service.dart';
import '../../services/user_preferences.dart';

class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<String> posts = [];

  @override
  void initState() {
    super.initState();
    loadUserPosts();
  }

  void loadUserPosts() async {
    var loadedPosts = await getUserPosts();
    setState(() {
      posts = loadedPosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    var localizationService = Provider.of<LocalizationService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizationService.getTranslatedValue('posts.title')),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText:
                    localizationService.getTranslatedValue('posts.newPost'),
              ),
              onSubmitted: (value) async {
                setState(() {
                  posts.add(value);
                });
                var userEmail = await saveUserPost(value);
                print(userEmail);
              },
            ),
          ),
        ],
      ),
    );
  }
}
