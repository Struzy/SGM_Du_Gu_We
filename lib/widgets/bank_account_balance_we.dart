import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/services/balance_format_service.dart';
import 'package:sgm_du_gu_we/widgets/update_balance.dart';
import '../constants/box_decoration.dart';
import '../constants/box_size.dart';
import '../constants/color.dart';
import '../constants/font_size.dart';
import '../services/authentication_service.dart';
import '../services/info_bar_service.dart';

// Widget for the bank account balance of Weigheim
class BankAccountBalanceWe extends StatefulWidget {
  const BankAccountBalanceWe({super.key});

  @override
  State<BankAccountBalanceWe> createState() => BankAccountBalanceWeState();
}

class BankAccountBalanceWeState extends State<BankAccountBalanceWe>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> balanceAnimation;
  double balance = 0.0;
  late User? loggedInUser;
  bool isEntitled = false;

  @override
  void initState() {
    super.initState();
    loggedInUser = AuthenticationService.getUser(context);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );
    balanceAnimation =
        Tween<double>(begin: 0.0, end: 0.0).animate(animationController);
    try {
      FirebaseFirestore.instance
          .collection('finance')
          .doc('5fr3PT4dFHryAiMv0LSP')
          .get()
          .then((snapshot) {
        if (snapshot.exists) {
          final double endValue =
              double.parse(snapshot['bankAccountBalanceWe']);
          balanceAnimation = Tween<double>(begin: 0.0, end: endValue)
              .animate(animationController)
            ..addListener(() {
              setState(() {
                balance = balanceAnimation.value;
              });
            });
          animationController.forward();
        }
      });
    } catch (e) {
      InfoBarService.showInfoBar(
        context: context,
        info: 'Betrag konnte nicht geladen werden.',
      );
    }
    isEntitled = assessEntitlement();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isNegative = balance < 0;
    Color balanceColor = isNegative ? kSGMColorRed : Colors.black;
    double screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('finance')
          .doc('5fr3PT4dFHryAiMv0LSP')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Wait fore the data to be available
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Kontostand',
                style: TextStyle(
                  fontSize: kFontsizeSubtitle,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Weigheim:',
                style: TextStyle(
                  fontSize: kFontsizeSubtitle,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: kBoxHeight,
              ),
              Flexible(
                child: Container(
                  width: screenWidth,
                  height: screenWidth,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: kSGMColorBlue,
                      width: kBorderWidth,
                    ),
                  ),
                  child: Center(
                    child: AnimatedBuilder(
                      animation: balanceAnimation,
                      builder: (context, child) {
                        String formattedBalance =
                            BalanceFormatService.formatBalance(balance);
                        return GestureDetector(
                          onTap: () {
                            if (isEntitled) {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    child: const UpdateBalance(
                                      title: 'Kontostand We aktualisieren',
                                      hintText: 'Neuen Kontostand angeben',
                                      balanceType: 'bankAccountBalanceWe',
                                      info:
                                          'Kontostand erfolgreich aktualisiert.',
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              InfoBarService.showInfoBar(
                                context: context,
                                info:
                                    'Es liegt keine Berechtigung für das Ändern des Kontostandes vor.',
                              );
                            }
                          },
                          child: Text(
                            formattedBalance,
                            style: TextStyle(
                              fontSize: kFontsizeBalance,
                              fontWeight: FontWeight.bold,
                              color: balanceColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Check whether user is entitled to perform modifications
  bool assessEntitlement() {
    if (loggedInUser?.displayName == 'Martin Müller') {
      return true;
    } else {
      return false;
    }
  }
}
