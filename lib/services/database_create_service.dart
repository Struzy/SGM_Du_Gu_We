import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/penalty.dart';
import '../models/vacation.dart';

class DatabaseCreateService {
  // Create vacation
  static Future createVacation(
      {required String startDate,
      required String endDate,
      required String name}) async {
    final docVacation =
        FirebaseFirestore.instance.collection('vacations').doc();
    final penalty = Vacation(
        id: docVacation.id, startDate: startDate, endDate: endDate, name: name);
    final json = penalty.toJson();
    await docVacation.set(json);
  }

  // Create penalty
  static Future createPenalty(
      {required String date,
      required String name,
      required String offense,
      required String amount}) async {
    final docPenalty = FirebaseFirestore.instance.collection('penalties').doc();
    final penalty = Penalty(
        id: docPenalty.id,
        date: date,
        name: name,
        offense: offense,
        amount: amount);
    final json = penalty.toJson();
    await docPenalty.set(json);
  }
}
