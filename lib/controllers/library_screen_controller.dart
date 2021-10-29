import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/models/book_model.dart';
import 'package:e_lib/models/issue_request_model.dart';
import 'package:e_lib/services/database_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LibraryScreenController extends GetxController {
  var booksDataList = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchBooks();
    super.onInit();
  }

  void fetchBooks() {
    booksDataList.clear();
    DatabaseHandler().fetchBooks(Get.arguments.libraryId).then((value) {
      value.docs.forEach((element) {
        Map<String, dynamic> docData = element.data() as dynamic;
        docData["bookDocId"] = element.id;
        BookModel bookModel = BookModel.fromJson(docData);
        booksDataList.add(bookModel);
        isLoading(false);
      });
      isLoading(false);
    });
  }

  Future<void> placeIssueRequest(BookModel bookModel, String libraryId) async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    await SharedPreferences.getInstance().then((pref) async {
      IssueRequestModel issueRequestModel = new IssueRequestModel(
        bookName: bookModel.bookName,
        authorName: bookModel.authorName,
        libraryId: libraryId,
        status: "Pending",
        userId: pref.getString(Utils.KEY_USERID),
        createdAt: DateTime.now(),
        approvedAt: DateTime.now(),
        issuedAt: DateTime.now(),
        returnedAt: DateTime.now(),
        declinedAt: DateTime.now(),
      );
      var data = issueRequestModel.toJson();
      await DatabaseHandler().placeIssueRequest(data);
      Get.back();
    });
  }
}
