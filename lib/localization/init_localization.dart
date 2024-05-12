import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'localization_texts.dart';

Future<Map<String, dynamic>> initLocalization() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? languageCode = prefs.getString('language');
  if (languageCode != null) {
    Locale locale = Locale(languageCode);
    if (locale.languageCode == 'uk') {
      return localizationData;
    }
  }
  return {};
}
