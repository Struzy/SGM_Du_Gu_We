import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/penalty.dart';
import '../models/vacation.dart';

/////////////////////////////////// VACATION ///////////////////////////////////
Stream<List<Vacation>> readVacations() => FirebaseFirestore.instance
    .collection('vacations')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Vacation.fromJson(doc.data())).toList());
/////////////////////////////////// VACATION ///////////////////////////////////

/////////////////////////////////// PENALTY ////////////////////////////////////
Stream<List<Penalty>> readPenalties() => FirebaseFirestore.instance
    .collection('penalties')
    .snapshots()
    .map((snapshot) =>
    snapshot.docs.map((doc) => Penalty.fromJson(doc.data())).toList());
/////////////////////////////////// PENALTY ////////////////////////////////////
