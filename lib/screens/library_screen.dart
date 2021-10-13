import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/Utils/app_ui_constants.dart';
import 'package:e_lib/controllers/library_screen_controller.dart';
import 'package:e_lib/models/library_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LibraryScreen extends StatelessWidget {
  final LibraryModel libraryModel;
  LibraryScreen({required this.libraryModel});

  final LibraryScreenController _libraryScreenController = Get.put(LibraryScreenController());

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
          libraryModel.libraryName!,
          color: Utils.primaryColor,
          fontSize: AppUIConst.baseFontSize * 4.5,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Utils.lightBgColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              padding: EdgeInsets.all(
                AppUIConst.safeBlockHorizontal * 2,
              ),
              child: Card(
                color: Utils.lightBgColor,
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: AppUIConst.screenHeight / 3.5,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: libraryModel.libraryImage!,
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: AppUIConst.safeBlockHorizontal * 2,
                        top: AppUIConst.safeBlockHorizontal * 4,
                      ),
                      child: Text(
                        libraryModel.libraryName!,
                        softWrap: true,
                        style: TextStyle(
                          color: Utils.black,
                          fontSize: AppUIConst.safeBlockHorizontal * 4.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: AppUIConst.safeBlockHorizontal * 2,
                        top: AppUIConst.safeBlockHorizontal * 1,
                      ),
                      child: Text(
                        libraryModel.type!,
                        style: TextStyle(
                          color: Utils.black,
                          fontSize: AppUIConst.safeBlockHorizontal * 4,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: AppUIConst.safeBlockHorizontal * 2,
                        top: AppUIConst.safeBlockHorizontal * 1,
                      ),
                      child: Text(
                        libraryModel.city!,
                        style: TextStyle(
                          color: Utils.black,
                          fontSize: AppUIConst.safeBlockHorizontal * 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              itemCount: _libraryScreenController.booksDataList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => getBookItem(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBookItem(int index) {
    return Container(
      margin: EdgeInsets.only(
        left: AppUIConst.safeBlockHorizontal * 2,
        right: AppUIConst.safeBlockHorizontal * 2,
        bottom: AppUIConst.safeBlockHorizontal * 3,
      ),
      child: Stack(
        children: [
          Card(
            shadowColor: Utils.white,
            elevation: 15,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            margin: EdgeInsets.only(
              right: AppUIConst.safeBlockHorizontal * 3.5,
            ),
            child: Container(
              height: AppUIConst.screenHeight / 5.5,
              child: Row(
                children: [
                  Container(
                    height: AppUIConst.screenHeight / 5.5,
                    width: AppUIConst.screenWidth / 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl:
                            "https://firebasestorage.googleapis.com/v0/b/e-lib-e53d6.appspot.com/o/28828394_950086555154619_9137006216337597187_o.jpg?alt=media&token=dd2c5145-1e19-43d6-ace7-6bede86f7a7d",
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Utils().getWithPadding(
                          Utils().getText(
                            _libraryScreenController.booksDataList[index].bookName,
                            fontSize: AppUIConst.baseFontSize * 4,
                          ),
                          top: AppUIConst.safeBlockVertical * 1,
                          right: AppUIConst.safeBlockHorizontal * 5,
                          left: AppUIConst.safeBlockHorizontal * 3,
                        ),
                        Utils().getWithPadding(
                          Utils().getText(
                            _libraryScreenController.booksDataList[index].authorName,
                            color: Utils.grey,
                            fontSize: AppUIConst.baseFontSize * 3.2,
                          ),
                          left: AppUIConst.safeBlockHorizontal * 3,
                          right: AppUIConst.safeBlockHorizontal * 3,
                          bottom: AppUIConst.safeBlockHorizontal * 2,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Utils.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          margin: EdgeInsets.only(
                            left: AppUIConst.safeBlockHorizontal * 3,
                          ),
                          child: Utils().getWithPadding(
                            Utils().getText(
                              "Quantity: " + _libraryScreenController.booksDataList[index].quantity.toString(),
                              color: Utils.white,
                              fontWeight: FontWeight.bold,
                              fontSize: AppUIConst.baseFontSize * 2.9,
                            ),
                            top: AppUIConst.safeBlockVertical * 0.3,
                            bottom: AppUIConst.safeBlockVertical * 0.3,
                            left: AppUIConst.safeBlockHorizontal * 2,
                            right: AppUIConst.safeBlockHorizontal * 2,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Utils().getWithPadding(
                              Utils().getText(
                                "₹" + _libraryScreenController.booksDataList[index].price.toString(),
                                color: Utils.green,
                                fontWeight: FontWeight.bold,
                                fontSize: AppUIConst.baseFontSize * 3.2,
                              ),
                              top: AppUIConst.safeBlockVertical * 1,
                              left: AppUIConst.safeBlockHorizontal * 3,
                            ),
                            Utils().getWithPadding(
                              Utils().getText(
                                "Security: " + _libraryScreenController.booksDataList[index].percentSecurity.toString() + "%",
                                color: Utils.primaryColor,
                                fontSize: AppUIConst.baseFontSize * 3.2,
                              ),
                              top: AppUIConst.safeBlockVertical * 1,
                              right: AppUIConst.safeBlockHorizontal * 2,
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Utils.primaryColor,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          margin: EdgeInsets.only(
                            left: AppUIConst.safeBlockHorizontal * 3,
                            bottom: AppUIConst.safeBlockVertical * 1,
                          ),
                          child: Utils().getWithPadding(
                            Utils().getText(
                              _libraryScreenController.booksDataList[index].category ?? "Category",
                              fontSize: AppUIConst.baseFontSize * 3.0,
                            ),
                            top: AppUIConst.safeBlockVertical * 0.2,
                            bottom: AppUIConst.safeBlockVertical * 0.2,
                            left: AppUIConst.safeBlockHorizontal * 2,
                            right: AppUIConst.safeBlockHorizontal * 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    // _libraryScreenController.editBookBottomSheet(index);
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Utils.blue,
                    child: Icon(
                      Icons.edit,
                      size: AppUIConst.iconExamHeightAndWidth * 0.5,
                      color: Utils.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () async {
                    var result = await Utils().showDialog(
                      "Alert",
                      "Are you sure you want to delete the book?",
                      () {
                        // _libraryScreenController.deleteBook(_libraryScreenController.booksDataList[index].bookDocId);
                        Get.back(result: "deleted");
                      },
                    );
                    if (result != null && result == "deleted") {
                      Utils().showConfirmSnackbar("Book deleted successfully");
                      _libraryScreenController.booksDataList.removeAt(index);
                    }
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Utils.red,
                    child: Icon(
                      Icons.delete,
                      size: AppUIConst.iconExamHeightAndWidth * 0.5,
                      color: Utils.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
