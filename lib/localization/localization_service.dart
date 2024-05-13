// localization_service.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService with ChangeNotifier {
  Locale _currentLocale = Locale('en');

  Locale get currentLocale => _currentLocale;

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
    // runApp(MaterialApp(
    //   home: Container(),
    // ));
  }

  static Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language') ?? 'en';
  }
}
