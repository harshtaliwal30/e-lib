import 'package:e_lib/models/library_model.dart';
import 'package:e_lib/services/database_handler.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenController extends GetxController {
  var librariesDataList = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchLibraries();
    super.onInit();
  }

  void fetchLibraries() {
    librariesDataList.clear();
    DatabaseHandler().fetchLibraries().then((value) {
      value.docs.forEach((element) {
        LibraryModel libraryModel = LibraryModel.fromJson(element.data() as dynamic);
        libraryModel.libraryId = element.id;
        librariesDataList.add(libraryModel);
        isLoading(false);
      });
      isLoading(false);
    });
  }

  // void fetchIssueRequests() {
  //   isLoading(true);
  //   SharedPreferences.getInstance().then((pref) {
  //     DatabaseHandler().fetchIssuedBooksByStatus(pref.getString(Utils.KEY_USERID), "Issued").then((value) {
  //       value.docs.forEach((element) {
  //         Map<String, dynamic> docData = element.data() as dynamic;
  //         docData["docId"] = element.id;
  //         IssueRequestModel issueRequestModel = IssueRequestModel.fromJson(docData);
  //         issuedBooksList.add(issueRequestModel);
  //         isLoading(false);
  //       });
  //       isLoading(false);
  //     });
  //   });
  // }
}
