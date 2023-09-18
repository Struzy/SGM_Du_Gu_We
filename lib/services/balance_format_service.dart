import 'package:intl/intl.dart';

class BalanceFormatService {
  BalanceFormatService({required this.balance});

  final String balance;

  static String formatBalance(double balance) {
    final formatter = NumberFormat("#,##0.00 \u20AC", "de_DE");
    return formatter.format(balance);
  }
}

