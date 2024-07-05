// localization_pl.dart
class LocalizationPL {
  static final Map<String, dynamic> _localizedValues = {
    'registerTitle': 'Register Form',
    'main': {
      'title': 'Aplikacja dostawcy Internetu',
      'enterFullName': 'Wprowadź swoje pełne imię'
    },
    'settings': {'title': 'Settings'},
    'menu': {
      'item1': 'Login',
      'item2': 'Rejestracja',
      'item3': 'Posty',
      'item4': 'Usługi',
    },
    'payment': {'title': 'Płatność', 'payButton': 'Zapłać'}
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
