// localization_en.dart
class LocalizationEN {
  static final Map<String, dynamic> _localizedValues = {
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
      'item5': 'Appointments',
    },
    'posts': {
      'title': 'User Posts',
      'newPost': 'New Post',
      'postButton': 'Post'
    },
    'services': {'title': 'Services', 'serviceButton': 'Service'},
    'payment': {'title': 'Payment', 'payButton': 'Pay'},
    'registration': {
      'title': 'Register Form',
      'name': 'Full Name *',
      'enterFullName': 'What do people call you?',
      'phoneNumber': 'Phone Number *',
      'phoneNumberHintText': 'Where can we reach you?',
      'phoneNumberHelperText': 'Phone format: (XXX)XXX-XXXX or XXX XXX XXXX',
      'phoneNumberValidationText':
          'Phone number must be entered as (###)###-#### or ### ### ####',
      'EmailAddress': 'Email Address',
      'inputEmailAddress': 'Enter a email address',
      'lifeStory': 'Life Story',
      'lifeStoryHintText': 'Tell us about your self',
      'lifeStoryHelperText': 'Keep it short, this is just a demo',
      'password': 'Password *',
      'passwordHintText': 'Enter the password',
      'confirmPassword': 'Confirm Password *',
      'confirmPasswordHintText': 'Confirm the password',
      'formNotValid': 'Form is not valid! Please review and correct',
      'validationEmptyEmail': 'Email cannot be empty',
      'validationInvalidEmail': 'Invalid email address',
      'validationPasswordLength': '8 character required for password',
      'validationPasswordMatch': 'Password does not match',
      'validationEmptyName': 'Name is required.',
      'validationAlphabeticalName': 'Please enter alphabetical characters.',
      'RegistrationSuccessful': 'Registration successful',
      'FromDataVerified': '- is a verified register form',
      'Verified': 'Save Data',
      'UserInfo': 'User Info',
    },
    'appointments': {
      'title': 'Appointment registration',
      'selectInterval': 'Select date interval',
      'selectStartDate': 'Select start date',
      'selectEndDate': 'Select end date',
      'selectTimeInterval': 'Select time interval',
      'selectStartTime': 'Select start time',
      'selectEndTime': 'Select end time',
      'selectedDateTime': 'Selected date and time:',
      'selectedTimeInterval': 'Selected time interval:',
      'notSelected': 'Not selected',
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
