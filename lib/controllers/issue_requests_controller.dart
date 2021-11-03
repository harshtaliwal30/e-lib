import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/models/issue_request_model.dart';
import 'package:e_lib/services/database_handler.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IssueRequestsController extends GetxController {
  var issueRequestsList = [].obs;
  var isLoading = true.obs;
  var selectedStatus = "Approved".obs;

  @override
  void onInit() {
    fetchIssueRequestsByStatus("Approved");
    super.onInit();
  }

  void fetchIssueRequestsByStatus(String status) {
    isLoading(true);
    issueRequestsList.clear();
    SharedPreferences.getInstance().then((pref) {
      DatabaseHandler().fetchIssuedBooksByStatus(pref.getString(Utils.KEY_USERID), status).then((value) {
        value.docs.forEach((element) {
          Map<String, dynamic> docData = element.data() as dynamic;
          docData["docId"] = element.id;
          IssueRequestModel issueRequestModel = IssueRequestModel.fromJson(docData);
          issueRequestsList.add(issueRequestModel);
          isLoading(false);
        });
        isLoading(false);
      });
    });
  }
}
