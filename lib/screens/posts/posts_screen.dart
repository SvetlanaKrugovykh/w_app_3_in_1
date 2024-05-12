import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<String> posts = []; // List to store user posts

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Posts'),
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
                labelText: 'New Post',
              ),
              onSubmitted: (value) {
                setState(() {
                  posts.add(value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
