// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import './constants/app_colors.dart';
import './screens/home/home_screen.dart';
import './localization/init_localization.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initLocalization(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: AppColors.primarySwatch,
            ),
            home:
                const HomeScreen(), // Измени точку входа на стартовую страницу
            localizationsDelegates: const [
              //AppLocalizations.delegate,
              // Другие делегаты локализации, если необходимо
              // GlobalMaterialLocalizations.delegate,
              // GlobalWidgetsLocalizations.delegate,
              // ...
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('uk'),
              Locale('pl'),
            ],
          );
        } else {
          return const CircularProgressIndicator(); // Можно добавить загрузочный экран
        }
      },
    );
  }
}
