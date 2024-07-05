// localization_uk.dart
class LocalizationUK {
  static final Map<String, dynamic> _localizedValues = {
    'registerTitle': 'Реєстраційна форма',
    'main': {
      'title': 'Додаток інтернет-провайдера',
      'enterFullName': "Введіть ваше повне ім'я"
    },
    'settings': {'title': 'Настроювання'},
    'menu': {
      'item1': 'Вхід',
      'item2': 'Реєстрація',
      'item3': 'Пости',
      'item4': 'Послуги',
    },
    'payment': {'title': 'Оплата', 'payButton': 'Pay'}
  };

  dynamic get(String key) {
    final keys = key.split('.');
    dynamic value = _localizedValues;
    for (final k in keys) {
      if (value is Map<String, dynamic> && value.containsKey(k)) {
        value = value[k];
      } else {
        return 'Key not found: $key';
      }
    }
    return value;
  }
}
