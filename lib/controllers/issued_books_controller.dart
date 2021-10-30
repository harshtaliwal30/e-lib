import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/models/issue_request_model.dart';
import 'package:e_lib/services/database_handler.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IssuedBooksController extends GetxController {
  var issuedBooksList = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchIssueRequests();
    super.onInit();
  }

  void fetchIssueRequests() {
    isLoading(true);
    issuedBooksList.clear();
    SharedPreferences.getInstance().then((pref) {
      DatabaseHandler().fetchIssuedBooksByStatus(pref.getString(Utils.KEY_USERID), "Issued").then((value) {
        value.docs.forEach((element) {
          Map<String, dynamic> docData = element.data() as dynamic;
          docData["docId"] = element.id;
          IssueRequestModel issueRequestModel = IssueRequestModel.fromJson(docData);
          issuedBooksList.add(issueRequestModel);
          isLoading(false);
        });
        isLoading(false);
      });
    });
  }
}
