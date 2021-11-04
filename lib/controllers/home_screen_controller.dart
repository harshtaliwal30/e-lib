import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/models/library_model.dart';
import 'package:e_lib/services/database_handler.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenController extends GetxController {
  var librariesDataList = [].obs;
  var isLoading = true.obs;
  var pendingRequestsCount = 0.obs;
  var approvedRequestsCount = 0.obs;
  var declinedRequestsCount = 0.obs;

  @override
  void onInit() {
    fetchLibraries();
    fetchIssueRequestsCount("Pending");
    fetchIssueRequestsCount("Approved");
    fetchIssueRequestsCount("Declined");
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

  void fetchIssueRequestsCount(String status) {
    SharedPreferences.getInstance().then((pref) {
      DatabaseHandler().fetchIssuedBooksByStatus(pref.getString(Utils.KEY_USERID), status).then((value) {
        if (status == "Pending") {
          pendingRequestsCount.value = value.docs.length;
        } else if (status == "Approved") {
          approvedRequestsCount.value = value.docs.length;
        } else {
          declinedRequestsCount.value = value.docs.length;
        }
      });
    });
  }
}
