import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../classes/penalty.dart';
import '../constants/color.dart';
import '../constants/elevated_button.dart';
import '../constants/padding.dart';

bool isLoading = true;

class PenaltyScreen extends StatefulWidget {
  const PenaltyScreen({super.key});

  static const String id = 'penalty_screen';

  @override
  PenaltyScreenState createState() => PenaltyScreenState();
}

class PenaltyScreenState extends State<PenaltyScreen> {
  Widget buildUser(Penalty penalty) => ListTile(
        leading: Image.network(
          penalty.profilePicture,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              isLoading = false;
              return child;
            }
            return const CircularProgressIndicator();
          },
        ),
        title: Text(
          '${penalty.surname}, ${penalty.forename}',
        ),
        subtitle: Text(
          penalty.date,
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.more_vert,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const AddPenalty(),
            );
          },
        ),
      );

//toIso8601String()

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Offene Strafen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<List<Penalty>>(
                stream: readPenalties(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Beim Laden der Einträge ist ein Fehler aufgetreten.',
                        ),
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final penalties = snapshot.data!;

                    return Expanded(
                      child: ListView(
                        children: penalties.map(buildUser).toList(),
                      ),
                    );
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {},
                    foregroundColor: Colors.black,
                    backgroundColor: kSGMColorRed,
                    elevation: kElevation,
                    child: const Icon(
                      Icons.add,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Create penalty
  Future createPenalty(
      {required String profilePicture,
      required String date,
      required String surname,
      required String forename,
      required String offense,
      required String amount,
      required String isPayed}) async {
    final docPenalty = FirebaseFirestore.instance.collection('penalties').doc();

    final penalty = Penalty(
        profilePicture: profilePicture,
        date: date,
        surname: surname,
        forename: forename,
        offense: offense,
        amount: amount,
        isPayed: isPayed);

    final json = penalty.toJson();

    await docPenalty.set(json);
  }

  // Read all penalties
  Stream<List<Penalty>> readPenalties() => FirebaseFirestore.instance
      .collection('penalties')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Penalty.fromJson(doc.data())).toList());

  // Update penalty
  void updatePenalty() {
    final penalty = FirebaseFirestore.instance.collection('penalties').doc();
    penalty.update({
      'forename': 'Manuel',
    });
  }

  // Delete penalty
  void deletePenalty() {
    final penalty = FirebaseFirestore.instance.collection('penalties').doc();
    penalty.delete();
  }
}

class AddPenalty extends StatelessWidget {
  const AddPenalty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff394E36),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                20.0,
              ),
              topRight: Radius.circular(
                20.0,
              ),
            )),
      ),
    );
  }
}
