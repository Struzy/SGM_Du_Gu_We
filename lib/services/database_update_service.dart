import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUpdateService {
  // Update vacation
  static void updateVacation(
      {required String id,
      required String startDate,
      required String endDate,
      required String name}) {
    final vacation = FirebaseFirestore.instance.collection('vacations').doc(id);
    vacation.update({
      'startDate': startDate,
      'endDate': endDate,
      'name': name,
    });
  }

  // Update penalty
  static void updatePenalty(
      {required String id,
      required String date,
      required String name,
      required String offense,
      required String amount}) {
    final penalty = FirebaseFirestore.instance.collection('penalties').doc(id);
    penalty.update({
      'date': date,
      'name': name,
      'offense': offense,
      'amount': amount,
    });
  }
}
