// localization_service.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/locale_provider.dart';
import 'localization_en.dart';
import 'localization_uk.dart';
import 'localization_pl.dart';

class LocalizationService extends ChangeNotifier {
  Locale _currentLocale;
  SharedPreferences _prefs;
  String get currentLanguage => _currentLocale.languageCode;

  List<Locale> supportedLocales = [Locale('en'), Locale('uk'), Locale('pl')];

  LocalizationService(this._currentLocale, this._prefs);

  final LocalizationEN _localizationEN = LocalizationEN();
  final LocalizationUK _localizationUK = LocalizationUK();
  final LocalizationPL _localizationPL = LocalizationPL();

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

  void updateLocale(Locale locale) {
    if (!supportedLocales.contains(locale)) return;

    _currentLocale = locale;
    _prefs.setString('language', locale.languageCode);
    notifyListeners();
  }

  String getTranslatedValue(String s) {
    switch (_currentLocale.languageCode) {
      case 'en':
        return _localizationEN.get(s);
      case 'uk':
        return _localizationUK.get(s);
      case 'pl':
        return _localizationPL.get(s);
      default:
        return 'Locale not supported';
    }
  }
}
