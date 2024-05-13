import 'package:flutter/material.dart';
import '../../localization/localization_service.dart';

import '../posts/posts_screen.dart';
import '../registration/registration_screen.dart';
import '../goods/goods_screen.dart';
import '../settings_screen.dart';
import '../subscreens/lang_choice.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    void _changeLanguage(BuildContext context, String languageCode) {
      // TODO: implement changeLanguage
    }

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: _getLocalizedText('main.title',
              defaultText: 'Internet Provider App'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return Text(snapshot.data ?? '');
            }
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 40.0),
            child: IconButton(
              icon: const Icon(Icons.language),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LangChoice(changeLanguage: _changeLanguage),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            FutureBuilder<String>(
              future: _getLocalizedText('settings.title'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return ListTile(
                    title: Text(snapshot.data ?? ''),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsScreen()),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        padding: const EdgeInsets.all(20),
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          _buildMenuButton(
              context, Icons.person_add, 'item2', const RegisterFormPage()),
          _buildMenuButton(context, Icons.article, 'item3', PostsScreen()),
          _buildMenuButton(
              context, Icons.article, 'item4', const GoodsScreen()),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, IconData icon, String labelKey,
      Widget destination) {
    return FutureBuilder<String>(
      future: _getLocalizedText('menu.$labelKey'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          return ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => destination),
              );
            },
            icon: Icon(icon),
            label: Text(snapshot.data ?? ''),
          );
        }
      },
    );
  }

  Future<String> _getLocalizedText(String key,
      {String defaultText = ''}) async {
    final localizationData = await LocalizationService.initLocalization();
    final languageCode = await LocalizationService.getLanguage();
    final languageData = localizationData[languageCode];
    final List<String> keys = key.split('.');
    if (languageData != null) {
      final registrationData = languageData[keys[0]];
      final String? registrationText = registrationData[keys[1]];
      return registrationText ?? '???';
    }
    return defaultText;
  }
}
