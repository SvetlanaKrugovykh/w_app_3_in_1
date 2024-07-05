// auth_screen.dart
import 'package:flutter/material.dart';
import '../../models/user.dart';

class ClientDataScreen extends StatelessWidget {
  const ClientDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Введите данные абонента'),
      ),
      body: AuthForm(),
    );
  }
}

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  // late String _fullName;
  // late String _email;
  // late String _phoneNumber;
  // late String _address;

  void _submitForm(User user) {
    // TODO: Implement your logic to handle the user object
    // print('User created: ${user.fullName}');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'ФИО'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите ваше ФИО';
              }
              return null;
            },
            onSaved: (value) {
              // _fullName = value!;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // User user = User(
                //   fullName: _fullName,
                //   login: '', //TODO: Implement login
                //   password: '', //TODO: Implement password
                //   email: _email,
                //   phoneNumber: _phoneNumber,
                //   //address: _address,
                // );
              }
            },
            child: const Text('Отправить'),
          ),
        ],
      ),
    );
  }
}
