// main.dart
import 'package:flutter/material.dart';
import './constants/app_colors.dart';
import './screens/home/home_screen.dart';
import 'localization/localization_service.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LocalizationService.initLocalization(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: AppColors.primarySwatch,
            ),
            home: const HomeScreen(),
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
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
