class LocalizationEN {
  static final Map<String, String> _localizedValues = {
    'registerTitle': 'Register Form',
    // Добавьте другие строки здесь
  };

  String get(String key) {
    return _localizedValues[key] ?? 'Key not found: $key';
  }
}
