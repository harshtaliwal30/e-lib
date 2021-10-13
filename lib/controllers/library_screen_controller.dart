import 'package:e_lib/services/database_handler.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LibraryScreenController extends GetxController {
  var booksDataList = [].obs;
  var isLoading = true.obs;

  // void fetchBooks() {
  //   booksDataList.clear();
  //   SharedPreferences.getInstance().then((pref) {
  //     DatabaseHandler().fetchBooks(pref.getString(Utils.KEY_LIBRARYID)).then((value) {
  //       value.docs.forEach((element) {
  //         Map<String, dynamic> docData = element.data() as dynamic;
  //         docData["bookDocId"] = element.id;
  //         BookModel bookModel = BookModel.fromJson(docData);
  //         booksDataList.add(bookModel);
  //         isLoading(false);
  //       });
  //       isLoading(false);
  //     });
  //   });
  // }
}
