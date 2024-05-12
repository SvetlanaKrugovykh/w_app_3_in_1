import 'package:flutter/material.dart';
import '../../localization/init_localization.dart';
import '../../localization/localization_texts.dart';

import '../posts/posts_screen.dart';
import '../registration/registration_screen.dart';
import '../auth/auth_screen.dart';
import '../account/account_screen.dart';
import '../payments/payment_screen.dart';
import '../settings_screen.dart';
import '../subscreens/lang_choice.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>>(
          future: initLocalization(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final localizationData = snapshot.data!;
                const languageCode =
                    'uk'; // 'en', 'uk', 'pl' TODO: get from settings
                if (languageCode == 'uk') {
                  return Text(localizationData['uk']['main']['title']);
                }
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
        child: ListView(
          children: [
            ListTile(
              title: Text(localizationData['uk']['settings']['title']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()),
                );
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
          _buildMenuButton(context, Icons.person,
              localizationData['uk']['menu']['item1'], const AuthScreen()),
          _buildMenuButton(
              context,
              Icons.person_add,
              localizationData['uk']['menu']['item2'],
              const RegisterFormPage()),
          _buildMenuButton(context, Icons.article,
              localizationData['uk']['menu']['item3'], PostsScreen()),
          // Add more menu buttons as needed
        ],
      ),
    );
  }

  Widget _buildMenuButton(
      BuildContext context, IconData icon, String label, Widget destination) {
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
}
