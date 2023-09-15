import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgm_du_gu_we/constants/color.dart';
import '../constants/box_size.dart';
import '../constants/font_size.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';
import '../widgets/navigation_drawer.dart' as nav;

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  static const String id = 'finance_screen';

  @override
  FinanceScreenState createState() => FinanceScreenState();
}

class FinanceScreenState extends State<FinanceScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: const nav.NavigationDrawer(),
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
          body: const Padding(
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

// Widget for the bank account balance of Durchhausen/Gunningen
class BankAccountBalanceDuGu extends StatefulWidget {
  const BankAccountBalanceDuGu({super.key});

  @override
  State<BankAccountBalanceDuGu> createState() => BankAccountBalanceDuGuState();
}

class BankAccountBalanceDuGuState extends State<BankAccountBalanceDuGu>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> balanceAnimation = AnimationController(vsync: this);
  double balance = 0.0;

  @override
  void initState() {
    super.initState();
    updateUI();
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
          return const CircularProgressIndicator();
        }
        String myValue = snapshot.data!['bankAccountBalanceDuGu'];
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
              Container(
                width: screenWidth,
                height: screenWidth,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kSGMColorBlue,
                    width: 4.0,
                  ),
                ),
                child: Center(
                  child: AnimatedBuilder(
                    animation: balanceAnimation,
                    builder: (context, child) {
                      String formattedBalance =
                          formatBalance(balanceAnimation.value);

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

  // Fetch bank account balance of Durchhausen/Gunningen from Firebase and
  // set animation
  void updateUI() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('finance')
          .doc('5fr3PT4dFHryAiMv0LSP')
          .get();

      setState(() {
        balance = double.parse(snapshot['bankAccountBalanceDuGu']);
        balanceAnimation =
            Tween<double>(begin: 0, end: balance).animate(animationController);
      });
      animationController.reset();
      animationController.forward();
    } catch (e) {
      showSnackBar(
        '$e.',
      );
    }

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    balanceAnimation = Tween<double>(begin: 0, end: balance).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    animationController.forward();
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

// Widget for cash balance of Durchhausen/Gunningen/Weigheim
class CashBalanceDuGuWe extends StatelessWidget {
  const CashBalanceDuGuWe({super.key});

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
                updateAccountBalance(balance);
                Navigator.pop(context);
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
void updateAccountBalance(String accountBalance) {
  final balance = FirebaseFirestore.instance
      .collection('finance')
      .doc('5fr3PT4dFHryAiMv0LSP');
  balance.update({
    'bankAccountBalanceDuGu': accountBalance,
  });
}
