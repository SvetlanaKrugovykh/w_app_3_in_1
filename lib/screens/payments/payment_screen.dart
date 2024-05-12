// payment_screen.dart
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Оплата'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Здесь можно добавить код для переадресации на виджет оплаты
          },
          child: const Text('Оплатить'),
        ),
      ),
    );
  }
}
