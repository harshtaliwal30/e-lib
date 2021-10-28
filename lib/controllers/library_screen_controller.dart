import 'package:e_lib/models/book_model.dart';
import 'package:e_lib/services/database_handler.dart';
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
    SharedPreferences.getInstance().then((pref) {
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
    });
  }
}
