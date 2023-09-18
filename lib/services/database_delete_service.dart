import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseDeleteService {
  // Delete vacation
  static void deleteVacation({required String id}) {
    final vacation = FirebaseFirestore.instance.collection('vacations').doc(id);
    vacation.delete();
  }

  // Delete penalty
  static void deletePenalty({required String id}) {
    final penalty = FirebaseFirestore.instance.collection('penalties').doc(id);
    penalty.delete();
  }
}
