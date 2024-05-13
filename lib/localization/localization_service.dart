// localization_service.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/locale_provider.dart';

class LocalizationService extends ChangeNotifier {
  Locale _currentLocale;
  SharedPreferences _prefs;

  List<Locale> supportedLocales = [Locale('en'), Locale('uk'), Locale('pl')];

  LocalizationService(this._currentLocale, this._prefs);

  Locale get currentLocale => _currentLocale;

  set currentLocale(Locale locale) {
    if (!supportedLocales.contains(locale)) return;

    _currentLocale = locale;
    _prefs.setString('language', locale.languageCode);
    notifyListeners();
  }

  static Future<LocalizationService> create() async {
    var prefs = await SharedPreferences.getInstance();
    var languageCode = prefs.getString('language') ?? 'en';
    return LocalizationService(Locale(languageCode), prefs);
  }

  static const Map<String, dynamic> localizationData = {
    "en": {
      "main": {
        "title": "Internet Provider App",
        "enterFullName": "Enter your full name"
      },
      "settings": {"title": "Settings"},
      "menu": {
        "item1": "Login",
        "item2": "Registration",
        "item3": "Posts",
        "item4": "Services",
      },
      "payment": {"title": "Payment", "payButton": "Pay"}
    },
    "uk": {
      "main": {
        "title": "Додаток інтернет-провайдера",
        "enterFullName": "Введіть ваше повне ім'я"
      },
      "settings": {"title": "Настроювання"},
      "menu": {
        "item1": "Вхід",
        "item2": "Реєстрація",
        "item3": "Пости",
        "item4": "Послуги",
      },
      "payment": {"title": "Оплата", "payButton": "Оплатити"}
    },
    "pl": {
      "main": {
        "title": "Aplikacja dostawcy Internetu",
        "enterFullName": "Wprowadź swoje pełne imię"
      },
      "settings": {"title": "Settings"},
      "menu": {
        "item1": "Login",
        "item2": "Rejestracja",
        "item3": "Posty",
        "item4": "Usługi",
      },
      "payment": {"title": "Płatność", "payButton": "Zapłać"}
    }
  };

  static Future<Map<String, dynamic>> initLocalization() async {
    await Future.delayed(Duration(seconds: 1));
    return localizationData;
  }

  static Future<void> changeLanguage(
      BuildContext context, String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    Provider.of<LocaleProvider>(context, listen: false).locale =
        Locale(languageCode);
    (context as Element).markNeedsBuild();
  }

  static Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language') ?? 'en';
  }
}
