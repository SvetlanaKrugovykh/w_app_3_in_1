import 'dart:async';

class LocalizationService {
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
        "item2": "Registration",
        "item3": "Posts",
      },
      "payment": {"title": "Płatność", "payButton": "Zapłać"}
    }
  };

  static Future<Map<String, dynamic>> initLocalization() async {
    // Emulate loading from an external source
    await Future.delayed(Duration(seconds: 1));

    // In a real app, you might fetch localization data from an API or a file
    return localizationData;
  }
}
