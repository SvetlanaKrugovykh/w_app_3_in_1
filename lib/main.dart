// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './screens/home/home_screen.dart';
import 'localization/localization_service.dart';
import 'package:logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalizationService localizationService = await LocalizationService.create();
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
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
    return FutureBuilder<LocalizationService>(
      future: LocalizationService.create(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final localizationService =
              Provider.of<LocalizationService>(context, listen: false);

          // Schedule the locale update after the build phase to avoid the exception
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (snapshot.data != null) {
              localizationService.updateLocale(snapshot.data!.currentLocale);
            }
          });

          return Consumer<LocalizationService>(
            builder: (context, localizationService, child) {
              return MaterialApp(
                locale: localizationService.currentLocale,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: const HomeScreen(),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: localizationService.supportedLocales,
              );
            },
          );
        }
      },
    );
  }
}
