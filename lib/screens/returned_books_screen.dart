import 'package:e_lib/Utils/size_config.dart';
import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/controllers/returned_books_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReturnedBooksScreen extends StatelessWidget {
  final ReturnedBooksController _returnedBooksController = Get.put(ReturnedBooksController());
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
          "Returned Books",
          color: Utils.primaryColor,
          fontSize: SizeConfig.baseFontSize * 4.5,
        ),
      ),
      body: Obx(
        () => _returnedBooksController.isLoading.isTrue
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _returnedBooksController.returnedBooksList.length == 0
                ? NoIssuedBooksView()
                : ListView.builder(
                    itemCount: _returnedBooksController.returnedBooksList.length,
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
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.safeBlockVertical * 1,
          horizontal: SizeConfig.safeBlockHorizontal * 3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Utils().getText(
              _returnedBooksController.returnedBooksList[index].bookName,
              color: Utils.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.baseFontSize * 3.7,
            ),
            Utils().getWithPadding(
              Utils().getText(
                _returnedBooksController.returnedBooksList[index].authorName,
                color: Utils.grey,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.baseFontSize * 3.2,
              ),
              bottom: SizeConfig.safeBlockVertical * 1,
            ),
            getStatusView("Pending", _returnedBooksController.returnedBooksList[index].createdAt),
            getStatusView("Approved", _returnedBooksController.returnedBooksList[index].approvedAt),
            getStatusView("Issued", _returnedBooksController.returnedBooksList[index].issuedAt),
            getStatusView("Returned", _returnedBooksController.returnedBooksList[index].returnedAt),
          ],
        ),
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
              "No Returned Books",
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
