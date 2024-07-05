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
    'payment': {'title': 'Оплата', 'payButton': 'Pay'},
    'registration': {
      'title': 'Реєстраційна форма',
      'name': "Повне ім'я *",
      'enterFullName': 'Як вас звати?',
      'phoneNumber': 'Телефон *',
      'phoneNumberHintText': 'Як ми можемо з вами зв’язатися?',
      'phoneNumberHelperText':
          'Формат номеру телефону: (XXX)XXX-XXXX або XXX XXX XXXX',
      'phoneNumberValidationText':
          'Номер телефону повинен бути введений у форматі (###)###-#### або ### ### ####',
      'EmailAddress': 'Адреса електронної пошти',
      'inputEmailAddress': 'Введіть адресу електронної пошти',
      'lifeStory': 'Життєвий шлях',
      'lifeStoryHintText': 'Розкажіть нам про себе',
      'lifeStoryHelperText': 'Будь ласка, коротко, це не суттєво',
      'password': 'Пароль *',
      'passwordHintText': 'Введіть пароль',
      'confirmPassword': 'Підтвердити пароль *',
      'confirmPasswordHintText': 'Підтвердіть пароль',
      'formNotValid': 'Форма недійсна! Будь ласка, перегляньте та виправте',
      'validationEmptyEmail': 'Електронна пошта не може бути порожньою',
      'validationInvalidEmail': 'Недійсна адреса електронної пошти',
      'validationPasswordLength': 'Для пароля потрібно 8 символів',
      'validationPasswordMatch': 'Пароль не збігається',
      'validationEmptyName': 'Ім’я обов’язкове.',
      'validationAlphabeticalName': 'Будь ласка, введіть буквені символи.',
      'RegistrationSuccessful': 'Реєстрація успішна',
      'FromDataVerified': '- форму реєстрації підтверджено',
      'Verified': 'Зберегти дані',
      'UserInfo': 'Інформація про користувача',
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
