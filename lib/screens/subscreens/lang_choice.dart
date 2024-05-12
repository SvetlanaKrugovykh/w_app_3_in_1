// screens/subscreens/lang_choice.dart
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class LangChoice extends StatelessWidget {
  const LangChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      onSelected: (String value) {
        if (value == 'back') {
          Navigator.pop(context);
        } else {
          _changeLanguage(context, value);
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'en',
            child: Text('English'),
          ),
          const PopupMenuItem<String>(
            value: 'uk',
            child: Text('Українська'),
          ),
          const PopupMenuItem<String>(
            value: 'pl',
            child: Text('Polski'),
          ),
          const PopupMenuItem<String>(
            value: 'back',
            child: Text('Back'),
          ),
        ];
      },
    );
  }

  void _changeLanguage(BuildContext context, String languageCode) async {
    Locale newLocale = Locale(languageCode);
    //AppLocalizations.delegate.load(newLocale);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', languageCode);
  }
}
