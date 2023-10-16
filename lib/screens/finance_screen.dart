import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/color.dart';
import 'package:sgm_du_gu_we/constants/font_size.dart';
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.account_balance,
                      color: Colors.black,
                    ),
                    Text(
                      'Konto Du/Gu',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: kFontsizeBody - 2,
                      ),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.euro,
                      color: Colors.black,
                    ),
                    Text(
                      'Kasse Du/Gu/We',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: kFontsizeBody - 2,
                      ),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.account_balance,
                      color: Colors.black,
                    ),
                    Text(
                      'Konto We',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: kFontsizeBody - 2,
                      ),
                    ),
                  ],
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
}
