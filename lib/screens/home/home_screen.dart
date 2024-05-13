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
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>>(
          future: LocalizationService.initLocalization(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final localizationData = snapshot.data!;
                final languageCode = 'uk'; // TODO: Get from settings
                final title = localizationData[languageCode]['main']['title'];
                return Text(title);
              }
              return const Text('Internet Provider App');
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
                  MaterialPageRoute(builder: (context) => const LangChoice()),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: FutureBuilder<Map<String, dynamic>>(
          future: LocalizationService.initLocalization(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final localizationData = snapshot.data!;
                final languageCode = 'uk'; // TODO: Get from settings
                return ListView(
                  children: [
                    ListTile(
                      title: Text(
                          localizationData[languageCode]['settings']['title']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsScreen()),
                        );
                      },
                    ),
                  ],
                );
              }
              return const SizedBox();
            }
          },
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
              context,
              Icons.person_add,
              'item2', // Используйте ключи напрямую
              const RegisterFormPage()),
          _buildMenuButton(
              context,
              Icons.article,
              'item3', // Используйте ключи напрямую
              PostsScreen()),
          _buildMenuButton(
              context,
              Icons.article,
              'item4', // Используйте ключи напрямую
              const GoodsScreen()),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, IconData icon, String labelKey,
      Widget destination) {
    return FutureBuilder<Map<String, dynamic>>(
      future: LocalizationService.initLocalization(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final localizationData = snapshot.data!;
            final languageCode = 'uk'; // TODO: Get from settings
            final label = localizationData[languageCode]['menu'][labelKey];
            return ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => destination),
                );
              },
              icon: Icon(icon),
              label: Text(label),
            );
          }
          return const SizedBox();
        }
      },
    );
  }
}
