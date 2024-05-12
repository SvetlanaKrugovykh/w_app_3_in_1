// account_screen.dart
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Статус абонента'),
      ),
      body: const Center(
        child: Text('Здесь будет отображаться состояние абонента'),
      ),
    );
  }
}
