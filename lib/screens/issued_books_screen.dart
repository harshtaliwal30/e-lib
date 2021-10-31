import 'package:e_lib/Utils/size_config.dart';
import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/controllers/issued_books_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class IssuedBooksScreen extends StatelessWidget {
  final IssuedBooksController _issuedBooksController = Get.put(IssuedBooksController());
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
          "Issued Books",
          color: Utils.primaryColor,
          fontSize: SizeConfig.baseFontSize * 4.5,
        ),
      ),
      body: Obx(
        () => _issuedBooksController.isLoading.isTrue
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _issuedBooksController.issuedBooksList.length == 0
                ? NoIssuedBooksView()
                : ListView.builder(
                    itemCount: _issuedBooksController.issuedBooksList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => getBookItem(index),
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
              _issuedBooksController.issuedBooksList[index].bookName,
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
              _issuedBooksController.issuedBooksList[index].authorName,
              color: Utils.grey,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.baseFontSize * 3.2,
            ),
            right: SizeConfig.safeBlockHorizontal * 3,
            left: SizeConfig.safeBlockHorizontal * 3,
            bottom: SizeConfig.safeBlockVertical * 1,
          ),
          if (_issuedBooksController.issuedBooksList[index].status == "Declined") ...[
            getStatusView("Declined", _issuedBooksController.issuedBooksList[index].declinedAt, color: Utils.red),
          ],
          if (_issuedBooksController.issuedBooksList[index].status == "Pending") ...[
            getStatusView("Pending", _issuedBooksController.issuedBooksList[index].createdAt),
          ],
          if (_issuedBooksController.issuedBooksList[index].status == "Approved") ...[
            getStatusView("Pending", _issuedBooksController.issuedBooksList[index].createdAt),
            getStatusView("Approved", _issuedBooksController.issuedBooksList[index].approvedAt),
          ],
          if (_issuedBooksController.issuedBooksList[index].status == "Issued") ...[
            getStatusView("Pending", _issuedBooksController.issuedBooksList[index].createdAt),
            getStatusView("Approved", _issuedBooksController.issuedBooksList[index].approvedAt),
            getStatusView("Issued", _issuedBooksController.issuedBooksList[index].issuedAt),
          ],
          if (_issuedBooksController.issuedBooksList[index].status == "Returned") ...[
            getStatusView("Pending", _issuedBooksController.issuedBooksList[index].createdAt),
            getStatusView("Approved", _issuedBooksController.issuedBooksList[index].approvedAt),
            getStatusView("Issued", _issuedBooksController.issuedBooksList[index].issuedAt),
            getStatusView("Returned", _issuedBooksController.issuedBooksList[index].returnedAt),
          ],
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 0,
            color: Utils.darkGrey,
            thickness: 0.5,
          ),
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

class NoIssuedBooksView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Utils().getWithPadding(
            Utils().getText(
              "No issued Books",
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
