import 'package:e_lib/Utils/size_config.dart';
import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/controllers/issue_requests_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum SortBy { pending, approved, declined }

class IssueRequestsScreen extends StatelessWidget {
  final IssueRequestsController _issueRequestController = Get.put(IssueRequestsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Utils.primaryColor),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Utils.white,
        title: Utils().getText(
          "Issue Requests",
          color: Utils.primaryColor,
          fontSize: SizeConfig.baseFontSize * 4.5,
        ),
      ),
      body: Obx(
        () => _issueRequestController.isLoading.isTrue
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockHorizontal * 2,
                      ),
                      child: PopupMenuButton(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Utils.primaryColor,
                            width: 0.5,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Utils.primaryColor),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal * 3,
                            vertical: SizeConfig.safeBlockVertical * 1,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Utils().getText(
                                "Sort by: ",
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.baseFontSize * 3.8,
                              ),
                              Utils().getText(
                                _issueRequestController.selectedStatus.value,
                                // fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.baseFontSize * 3.8,
                              ),
                            ],
                          ),
                        ),
                        onSelected: (result) {
                          print(result);
                          _issueRequestController.selectedStatus.value = result.toString();
                          if (result == "Pending") {
                            _issueRequestController.fetchIssueRequestsByStatus("Pending");
                          } else if (result == "Approved") {
                            _issueRequestController.fetchIssueRequestsByStatus("Approved");
                          } else if (result == "Declined") {
                            _issueRequestController.fetchIssueRequestsByStatus("Declined");
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          const PopupMenuItem(
                            value: "Pending",
                            child: Text('Pending'),
                          ),
                          const PopupMenuItem(
                            value: "Approved",
                            child: Text('Approved'),
                          ),
                          const PopupMenuItem(
                            value: "Declined",
                            child: Text('Declined'),
                          ),
                        ],
                      ),
                    ),
                    _issueRequestController.issueRequestsList.length == 0
                        ? NoIssueRequestsView()
                        : ListView.builder(
                            itemCount: _issueRequestController.issueRequestsList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => getBookItem(index),
                          ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget getBookItem(int index) {
    return Card(
      color: Utils.white,
      shadowColor: Utils.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        side: BorderSide(
          color: Utils.darkGrey,
          width: 0.5,
        ),
      ),
      margin: EdgeInsets.only(
        left: SizeConfig.safeBlockHorizontal * 2,
        right: SizeConfig.safeBlockHorizontal * 2,
        top: SizeConfig.safeBlockVertical * 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Utils().getWithPadding(
            Utils().getText(
              _issueRequestController.issueRequestsList[index].bookName,
              color: Utils.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.baseFontSize * 3.7,
            ),
            top: SizeConfig.safeBlockVertical * 1,
            right: SizeConfig.safeBlockHorizontal * 3,
            left: SizeConfig.safeBlockHorizontal * 3,
          ),
          Utils().getWithPadding(
            Utils().getText(
              _issueRequestController.issueRequestsList[index].authorName,
              color: Utils.grey,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.baseFontSize * 3.2,
            ),
            right: SizeConfig.safeBlockHorizontal * 3,
            left: SizeConfig.safeBlockHorizontal * 3,
            bottom: SizeConfig.safeBlockVertical * 1,
          ),
          if (_issueRequestController.issueRequestsList[index].status == "Declined") ...[
            getStatusView("Declined", _issueRequestController.issueRequestsList[index].declinedAt, color: Utils.red),
          ],
          if (_issueRequestController.issueRequestsList[index].status == "Pending") ...[
            getStatusView("Pending", _issueRequestController.issueRequestsList[index].createdAt),
          ],
          if (_issueRequestController.issueRequestsList[index].status == "Approved") ...[
            getStatusView("Pending", _issueRequestController.issueRequestsList[index].createdAt),
            getStatusView("Approved", _issueRequestController.issueRequestsList[index].approvedAt),
          ],
          if (_issueRequestController.issueRequestsList[index].status == "Issued") ...[
            getStatusView("Pending", _issueRequestController.issueRequestsList[index].createdAt),
            getStatusView("Approved", _issueRequestController.issueRequestsList[index].approvedAt),
            getStatusView("Issued", _issueRequestController.issueRequestsList[index].issuedAt),
          ],
          if (_issueRequestController.issueRequestsList[index].status == "Returned") ...[
            getStatusView("Pending", _issueRequestController.issueRequestsList[index].createdAt),
            getStatusView("Approved", _issueRequestController.issueRequestsList[index].approvedAt),
            getStatusView("Issued", _issueRequestController.issueRequestsList[index].issuedAt),
            getStatusView("Returned", _issueRequestController.issueRequestsList[index].returnedAt),
          ],
        ],
      ),
    );
  }

  Widget getStatusView(
    String status,
    DateTime date, {
    Color color = Utils.green,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Utils().getWithPadding(
          Column(
            children: [
              Utils().getChipView("◉", color: color),
              Container(
                color: color.withOpacity(0.6),
                width: 0.5,
                height: 8,
              ),
            ],
          ),
          left: SizeConfig.safeBlockHorizontal * 3,
          right: SizeConfig.safeBlockHorizontal * 1,
        ),
        Utils().getText(
          status + " - ",
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: SizeConfig.baseFontSize * 3,
        ),
        Utils().getText(
          DateFormat.yMMMEd().format(date).toString(),
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: SizeConfig.baseFontSize * 2.9,
        ),
      ],
    );
  }
}

class NoIssueRequestsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Utils().getWithPadding(
            Utils().getText(
              "No issue Requests",
              color: Utils.darkGrey,
              fontWeight: FontWeight.bold,
            ),
            top: SizeConfig.safeBlockVertical * 2,
            bottom: SizeConfig.safeBlockVertical * 2,
          ),
          Image.asset(
            "assets/images/issue.png",
            height: SizeConfig.screenWidth / 1.5,
          ),
        ],
      ),
    );
  }
}
