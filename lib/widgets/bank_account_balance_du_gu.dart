import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgm_du_gu_we/widgets/update_balance.dart';
import '../constants/box_size.dart';
import '../constants/color.dart';
import '../constants/font_size.dart';

// Widget for the bank account balance of Durchhausen/Gunningen
class BankAccountBalanceDuGu extends StatefulWidget {
  const BankAccountBalanceDuGu({super.key});

  @override
  State<BankAccountBalanceDuGu> createState() => BankAccountBalanceDuGuState();
}

class BankAccountBalanceDuGuState extends State<BankAccountBalanceDuGu>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> balanceAnimation;
  double balance = 0.0;

  @override
  void initState() {
    super.initState();
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
              double.parse(snapshot['bankAccountBalanceDuGu']);
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
      showSnackBar(
        'Betrag konnte nicht geladen werden.',
      );
    }
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
                'Kontostand Durchhausen/Gunningen:',
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
                      width: 5.0,
                    ),
                  ),
                  child: Center(
                    child: AnimatedBuilder(
                      animation: balanceAnimation,
                      builder: (context, child) {
                        String formattedBalance = formatBalance(balance);
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).viewInsets.bottom,
                                  ),
                                  child: const UpdateBalance(),
                                ),
                              ),
                            );
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

  // Helper function to format the balance using German spelling and the Euro sign
  String formatBalance(double balance) {
    final formatter = NumberFormat("#,##0.00 \u20AC", "de_DE");
    return formatter.format(balance);
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
