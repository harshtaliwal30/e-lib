import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHandler {
  final databaseReference = FirebaseFirestore.instance;

  Future<QuerySnapshot> checkUserAvailableUsingPhone(String phoneNumber) {
    return databaseReference.collection("users").where("userPhone", isEqualTo: phoneNumber).get();
  }

  Future<String?> addUser(var data) async {
    String? userId;
    await databaseReference.collection('users').add(data).then((value) {
      userId = value.id;
    });
    return userId;
  }

  Future<QuerySnapshot> fetchLibraries() {
    return databaseReference.collection("libraries").get();
  }

  Future<QuerySnapshot> fetchBooks(String? libraryId) {
    return databaseReference.collection('books').where('libraryId', isEqualTo: libraryId).orderBy("createdAt", descending: true).get();
  }

  Future<void> placeIssueRequest(var data) async {
    await databaseReference.collection('issueRequests').add(data);
  }
}
