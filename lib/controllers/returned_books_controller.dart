import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/models/issue_request_model.dart';
import 'package:e_lib/services/database_handler.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReturnedBooksController extends GetxController {
  var returnedBooksList = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchIssueRequests();
    super.onInit();
  }

  void fetchIssueRequests() {
    isLoading(true);
    returnedBooksList.clear();
    SharedPreferences.getInstance().then((pref) {
      DatabaseHandler().fetchIssuedBooksByStatus(pref.getString(Utils.KEY_USERID), "Returned").then((value) {
        value.docs.forEach((element) {
          Map<String, dynamic> docData = element.data() as dynamic;
          docData["docId"] = element.id;
          IssueRequestModel issueRequestModel = IssueRequestModel.fromJson(docData);
          returnedBooksList.add(issueRequestModel);
          isLoading(false);
        });
        isLoading(false);
      });
    });
  }
}
