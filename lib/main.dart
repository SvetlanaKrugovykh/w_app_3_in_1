// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:internet_provider_app/screens/subscreens/lang_choice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './constants/app_colors.dart';
import './screens/home/home_screen.dart';
import 'localization/localization_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('language', 'uk');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocalizationService(),
      child: Consumer<LocalizationService>(
        builder: (context, localizationService, child) {
          return FutureBuilder(
            future: LocalizationService.initLocalization(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return MaterialApp(
                  locale: localizationService.currentLocale,
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: const HomeScreen(),
                  localizationsDelegates: const [
                    // Добавьте ваши делегаты локализации
                  ],
                  supportedLocales: const [
                    Locale('en'),
                    Locale('uk'),
                    Locale('pl'),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
        },
      ),
    );
  }
}
