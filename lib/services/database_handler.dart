import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHandler {
  final databaseReference = FirebaseFirestore.instance;

  Future<QuerySnapshot> fetchLibraries() {
    return databaseReference.collection("libraries").get();
  }
}
