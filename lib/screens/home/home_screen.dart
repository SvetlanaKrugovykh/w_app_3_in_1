import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../localization/localization_service.dart';

import '../posts/posts_screen.dart';
import '../registration/registration_screen.dart';
import '../goods/goods_screen.dart';
import '../appointments/appointments_screen.dart';
import '../settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var localizationService = Provider.of<LocalizationService>(context);
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: Future.value(
              localizationService.getTranslatedValue('main.title')),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return Text(snapshot.data ?? '');
            }
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            FutureBuilder<String>(
              future: Future.value(
                  localizationService.getTranslatedValue('settings.title')),
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
          _buildMenuButton(context, Icons.calendar_month, 'item5',
              const AppointmentsScreen()),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, IconData icon, String labelKey,
      Widget destination) {
    var localizationService = Provider.of<LocalizationService>(context);
    return FutureBuilder<String>(
      future: Future.value(
          localizationService.getTranslatedValue('menu.$labelKey')),
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
}
