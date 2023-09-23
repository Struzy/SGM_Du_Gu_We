import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/color.dart';
import '../constants/padding.dart';
import '../widgets/bank_account_balance_du_gu.dart';
import '../widgets/bank_account_balance_we.dart';
import '../widgets/cash_balance_du_gu_we.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  static const String id = 'finance_screen';

  @override
  FinanceScreenState createState() => FinanceScreenState();
}

class FinanceScreenState extends State<FinanceScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Finanzen',
          ),
          bottom: const TabBar(
            indicatorColor: kSGMColorRed,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.account_balance,
                  color: Colors.black,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.euro,
                  color: Colors.black,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.account_balance,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(
              kPadding,
            ),
            child: TabBarView(
              children: [
                BankAccountBalanceDuGu(),
                CashBalanceDuGuWe(),
                BankAccountBalanceWe(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Show snack bar
  void showSnackBar(String snackBarText) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          snackBarText,
        ),
      ),
    );
  }
}
