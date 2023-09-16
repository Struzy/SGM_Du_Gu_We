import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/screens/finance_screen.dart';
import '../constants/box_size.dart';
import '../constants/font_size.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';

class UpdateBalance extends StatefulWidget {
  const UpdateBalance({super.key});

  @override
  UpdateBalanceState createState() => UpdateBalanceState();
}

class UpdateBalanceState extends State<UpdateBalance> {
  TextEditingController controller = TextEditingController();
  String balance = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(
        0xff394E36,
      ),
      child: Container(
        padding: const EdgeInsets.all(
          kPadding,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              20.0,
            ),
            topRight: Radius.circular(
              20.0,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Kontostand aktualisieren',
              style: TextStyle(
                fontSize: kFontsizeSubtitle,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            TextField(
              controller: controller,
              autofocus: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
              ),
              onChanged: (value) {
                balance = value;
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.account_balance),
                hintText: 'Neuen Kontostand angeben',
              ),
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            ElevatedButton.icon(
              onPressed: () {
                updateBalance(
                  type: 'bankAccountBalanceDuGu',
                  newValue: balance,
                );
                Navigator.pushNamed(
                  context,
                  FinanceScreen.id,
                );
              },
              icon: const Icon(
                Icons.update,
                color: Colors.black,
                size: kIcon,
              ),
              label: const Text(
                'Aktualisieren',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Update penalty
void updateBalance({required String type, required String newValue}) {
  final balance = FirebaseFirestore.instance
      .collection('finance')
      .doc('5fr3PT4dFHryAiMv0LSP');
  balance.update({
    type: newValue,
  });
}
