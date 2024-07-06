import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserData(Map<String, dynamic> userData) async {
  final prefs = await SharedPreferences.getInstance();
  String userJson = jsonEncode(userData);
  await prefs.setString('userData', userJson);
}

Future<Map<String, dynamic>?> loadUserData() async {
  final prefs = await SharedPreferences.getInstance();
  String? userJson = prefs.getString('userData');
  if (userJson != null) {
    return jsonDecode(userJson);
  }
  return null;
}

Future<List<String>> getUserPosts() async {
  final prefs = await SharedPreferences.getInstance();
  // Retrieve the posts JSON string using the key 'userPosts'.
  String? postsJson = prefs.getString('userPosts');
  if (postsJson != null) {
    // Decode the JSON string into a list of strings.
    List<String> posts = List<String>.from(json.decode(postsJson));
    return posts;
  } else {
    // Return an empty list if there are no saved posts.
    return [];
  }
}

Future<String> saveUserPost(String post) async {
  final prefs = await SharedPreferences.getInstance();
  // Retrieve and decode the existing list of posts, if any.
  String? postsJson = prefs.getString('userPosts');
  List<String> posts = [];
  if (postsJson != null) {
    posts = List<String>.from(json.decode(postsJson));
  }
  // Add the new post to the list and encode it back to a string.
  posts.add(post);
  postsJson = json.encode(posts);
  await prefs.setString('userPosts', postsJson);
  // Retrieve the user email, if it exists.
  String? userEmail = prefs.getString('userEmail');
  // Return the userEmail if it exists, otherwise return a default value.
  return userEmail ?? "No email found";
}
