import 'package:flutter/material.dart';

// Widget for the bank account balance of Weigheim
class BankAccountBalanceWe extends StatelessWidget {
  const BankAccountBalanceWe({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Content 1 for Tab 1',
          ),
          Text(
            'Content 2 for Tab 2',
          ),
          Text(
            'Content 3 for Tab 3',
          ),
        ],
      ),
    );
  }
}