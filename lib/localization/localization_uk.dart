class LocalizationUK {
  static final Map<String, String> _localizedValues = {
    'registerTitle': 'реєстраційна форма',
    // Добавьте другие строки здесь
  };

  String get(String key) {
    return _localizedValues[key] ?? 'Key not found: $key';
  }
}
