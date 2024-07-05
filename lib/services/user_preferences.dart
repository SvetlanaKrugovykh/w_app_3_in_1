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
