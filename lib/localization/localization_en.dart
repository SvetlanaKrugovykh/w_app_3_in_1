// localization_en.dart
class LocalizationEN {
  static final Map<String, dynamic> _localizedValues = {
    'registerTitle': 'Register Form',
    'main': {
      'title': 'Internet Provider App',
      'enterFullName': 'Enter your full name'
    },
    'settings': {'title': 'Settings'},
    'menu': {
      'item1': 'Login',
      'item2': 'Registration',
      'item3': 'Posts',
      'item4': 'Services',
    },
    'payment': {'title': 'Payment', 'payButton': 'Pay'}
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
