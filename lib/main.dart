// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/home/home_screen.dart';
import 'localization/localization_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalizationService localizationService = await LocalizationService.create();
  runApp(
    ChangeNotifierProvider(
      create: (context) => localizationService,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationService>(
      builder: (context, localizationService, child) {
        return MaterialApp(
          locale: localizationService.currentLocale,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(),
          localizationsDelegates: const [
            // Добавьте ваши делегаты локализации
          ],
        );
      },
    );
  }
}
