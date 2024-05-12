import 'package:flutter/material.dart';
import '../../models/user.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
      ),
      body: AuthForm(),
    );
  }
}

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  late String _login;
  late String _password;

  void _submitForm(User user) {
    // TODO: Implement your logic to handle the user object
    print('User logged in: ${user.login}');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Логин'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите ваш логин';
              }
              return null;
            },
            onSaved: (value) {
              _login = value!;
            },
          ),
          const SizedBox(height: 20), // Добавим пространство между полями
          TextFormField(
            decoration: InputDecoration(labelText: 'Пароль'),
            obscureText: true, // Скрыть текст ввода для пароля
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите ваш пароль';
              }
              return null;
            },
            onSaved: (value) {
              _password = value!;
            },
          ),
          const SizedBox(height: 20), // Добавим еще немного пространства
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Создай новый объект User с полученными данными
                User user = User(
                  login: _login,
                  password: _password,
                  email: '',
                  phoneNumber: '',
                );
                _submitForm(user);
              }
            },
            child: const Text('Войти'),
          ),
        ],
      ),
    );
  }
}
