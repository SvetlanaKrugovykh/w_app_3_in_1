import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../../localization/localization_service.dart';
import '../../models/user.dart';
import '../../services/api_service.dart';
import 'user_info_page.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  Map<String, String> validationMessages = {};
  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  final List<String> _countries = ['Ukraine', 'Poland', 'Germany', 'USA'];
  String _selectedCountry = 'Ukraine';

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  User newUser = User(login: '', password: '', phoneNumber: '', email: '');
  void initState() {
    super.initState();
    var localizationService =
        Provider.of<LocalizationService>(context, listen: false);
    validationMessages = {
      'validationEmptyEmail': localizationService
          .getTranslatedValue('registration.validationEmptyEmail'),
      'validationInvalidEmail': localizationService
          .getTranslatedValue('registration.validationInvalidEmail'),
      'validationPasswordLength': localizationService
          .getTranslatedValue('registration.validationPasswordLength'),
      'validationPasswordMatch': localizationService
          .getTranslatedValue('registration.validationPasswordMatch'),
      'validationEmptyName': localizationService
          .getTranslatedValue('registration.validationEmptyName'),
      'validationAlphabeticalName': localizationService
          .getTranslatedValue('registration.validationAlphabeticalName'),
      'RegistrationSuccessful': localizationService
          .getTranslatedValue('registration.RegistrationSuccessful'),
      'FromDataVerified': localizationService
          .getTranslatedValue('registration.FromDataVerified'),
      'Verified':
          localizationService.getTranslatedValue('registration.Verified'),
    };
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    var localizationService = Provider.of<LocalizationService>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title:
            Text(localizationService.getTranslatedValue('registration.title')),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              decoration: InputDecoration(
                labelText:
                    localizationService.getTranslatedValue('registration.name'),
                hintText: localizationService
                    .getTranslatedValue('main.enterFullName'),
                prefixIcon: const Icon(Icons.person),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _nameController.clear();
                  },
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              validator: _validateName,
              onSaved: (value) => newUser.name = value!,
            ),
            const SizedBox(height: 10),
            TextFormField(
              focusNode: _phoneFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _phoneFocus, _passFocus);
              },
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: localizationService
                    .getTranslatedValue('registration.phoneNumber'),
                hintText: localizationService
                    .getTranslatedValue('registration.phoneNumberHintText'),
                helperText: localizationService
                    .getTranslatedValue('registration.phoneNumberHelperText'),
                prefixIcon: const Icon(Icons.call),
                suffixIcon: GestureDetector(
                  onLongPress: () {
                    _phoneController.clear();
                  },
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                // FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,15}$'),
                    allow: true),
              ],
              validator: (value) => _validatePhoneNumber(value!)
                  ? null
                  : localizationService.getTranslatedValue(
                      'registration.phoneNumberValidationText'),
              onSaved: (value) => newUser.phoneNumber = value!,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: localizationService
                    .getTranslatedValue('registration.EmailAddress'),
                hintText: localizationService
                    .getTranslatedValue('registration.inputEmailAddress'),
                icon: Icon(Icons.mail),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
              onSaved: (value) => newUser.email = value!,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.map),
                  labelText: 'Country?'),
              items: _countries.map((country) {
                return DropdownMenuItem(
                  child: Text(country),
                  value: country,
                );
              }).toList(),
              onChanged: (country) {
                print(country);
                setState(() {
                  _selectedCountry = country as String;
                  newUser.country = country;
                });
              },
              value: _selectedCountry,
              // validator: (val) {
              //   return val == null ? 'Please select a country' : null;
              // },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _storyController,
              decoration: InputDecoration(
                labelText: localizationService
                    .getTranslatedValue('registration.lifeStory'),
                hintText: localizationService
                    .getTranslatedValue('registration.lifeStoryHintText'),
                helperText: localizationService
                    .getTranslatedValue('registration.lifeStoryHelperText'),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              onSaved: (value) => newUser.story = value!,
            ),
            const SizedBox(height: 10),
            TextFormField(
              focusNode: _passFocus,
              controller: _passController,
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: localizationService
                    .getTranslatedValue('registration.password'),
                hintText: localizationService
                    .getTranslatedValue('registration.passwordHintText'),
                suffixIcon: IconButton(
                  icon:
                      Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
                icon: const Icon(Icons.security),
              ),
              validator: _validatePassword,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _confirmPassController,
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: localizationService
                    .getTranslatedValue('registration.confirmPassword'),
                hintText: localizationService
                    .getTranslatedValue('registration.confirmPasswordHintText'),
                icon: Icon(Icons.border_color),
              ),
              validator: _validatePassword,
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              child: const Text('Submit Form'),
              onPressed: () => _submitForm(localizationService
                  .getTranslatedValue('registration.formNotValid')),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                textStyle: const TextStyle(color: Colors.white),
              ),
              //color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm(msgFormNotValid) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showDialog(name: _nameController.text);
      log('fullName: ${_nameController.text}');
      log('phoneNumber: ${_phoneController.text}');
      log('Email: ${_emailController.text}');
      log('Country: $_selectedCountry');
      log('Story: ${_storyController.text}');
    } else {
      _showMessage(message: msgFormNotValid);
    }
  }

  String? _validateName(String? value) {
    final _nameExp = RegExp(r'^[A-Za-zА-Яа-яЁёІіЇїҐґЄєĄąĆćĘęŁłŃńÓóŚśŹźŻż ]+$');
    if (value == null) {
      return validationMessages['validationEmptyName'];
    } else if (!_nameExp.hasMatch(value)) {
      return validationMessages['validationAlphabeticalName'];
    } else {
      return null;
    }
  }

  bool _validatePhoneNumber(String input) {
    final _phoneExp = RegExp(r'^(\+)?[0-9 ]*(\([0-9 ]*)?([0-9 ]*)?([0-9]*)?$');
    return _phoneExp.hasMatch(input);
  }

  String? _validateEmail(String? value) {
    if (value == null) {
      return validationMessages['validationEmptyEmail'];
    } else if (!_emailController.text.contains('@')) {
      return validationMessages['validationInvalidEmail'];
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (_passController.text.length != 8) {
      return validationMessages['validationPasswordLength'];
    } else if (_confirmPassController.text != _passController.text) {
      return validationMessages['validationPasswordMatch'];
    } else {
      return null;
    }
  }

  void _showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  void _showDialog({required String name}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            validationMessages['RegistrationSuccessful']!,
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          content: Text(
            "$name ${validationMessages['FromDataVerified']}",
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Map<String, dynamic> userData = {
                  "name": name,
                  "phone": _phoneController.text,
                  "email": _emailController.text,
                  "country": _selectedCountry,
                  "story": _storyController.text,
                  "password": _passController.text,
                };
                await ApiService().sendUserData(userData);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoPage(
                      userInfo: newUser,
                    ),
                  ),
                );
              },
              child: Text(
                validationMessages['Verified']!,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
