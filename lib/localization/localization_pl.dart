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
    'payment': {'title': 'Płatność', 'payButton': 'Zapłać'},
    'registration': {
      'title': 'Formularz rejestracyjny',
      'name': 'Imię i nazwisko *',
      'enterFullName': 'Jak się nazywasz?',
      'phoneNumber': 'Numer telefonu *',
      'phoneNumberHintText': 'Jak możemy się z tobą skontaktować?',
      'phoneNumberHelperText':
          'Format numeru telefonu: (XXX)XXX-XXXX lub XXX XXX XXXX',
      'phoneNumberValidationText':
          'Numer telefonu musi być wprowadzony w formacie (###)###-#### lub ### ### ####',
      'EmailAddress': 'Adres e-mail',
      'inputEmailAddress': 'Wprowadź adres e-mail',
      'lifeStory': 'Historia życia',
      'lifeStoryHintText': 'Opowiedz nam o sobie',
      'lifeStoryHelperText': 'Krótko, to nie jest istotne',
      'password': 'Hasło *',
      'passwordHintText': 'Wprowadź hasło',
      'confirmPassword': 'Potwierdź hasło *',
      'confirmPasswordHintText': 'Potwierdź hasło',
      'formNotValid': 'Formularz jest nieprawidłowy! Proszę sprawdź i popraw',
      'validationEmptyEmail': 'E-mail nie może być pusty',
      'validationInvalidEmail': 'Nieprawidłowy adres e-mail',
      'validationPasswordLength': 'Hasło wymaga 8 znaków',
      'validationPasswordMatch': 'Hasła nie pasują',
      'validationEmptyName': 'Imię jest wymagane.',
      'validationAlphabeticalName': 'Proszę wprowadzić znaki alfabetyczne.',
      'RegistrationSuccessful': 'Rejestracja zakończona sukcesem',
      'FromDataVerified': 'teraz formularz rejestracyjny jest zweryfikowany',
      'Verified': 'Zapisz dane',
    },
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
