import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/Utils/size_config.dart';
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
          fontSize: SizeConfig.baseFontSize * 4.5,
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(
                  SizeConfig.safeBlockHorizontal * 2,
                ),
                child: Card(
                  color: Utils.primaryColor,
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: SizeConfig.screenHeight / 4,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: libraryModel.libraryImage!,
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.safeBlockHorizontal * 2,
                          top: SizeConfig.safeBlockVertical * 2,
                        ),
                        child: Text(
                          libraryModel.libraryName!,
                          softWrap: true,
                          style: TextStyle(
                            color: Utils.white,
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.safeBlockHorizontal * 2,
                        ),
                        child: Text(
                          libraryModel.address! + ", " + libraryModel.city! + ", " + libraryModel.state! + ", " + libraryModel.country!,
                          style: TextStyle(
                            color: Utils.grey,
                            fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.safeBlockHorizontal * 2,
                          top: SizeConfig.safeBlockVertical * 0.5,
                        ),
                        child: Text(
                          libraryModel.libraryEmail!,
                          style: TextStyle(
                            color: Utils.lightGrey,
                            fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.safeBlockHorizontal * 2,
                          top: SizeConfig.safeBlockVertical * 0.5,
                          bottom: SizeConfig.safeBlockVertical * 2,
                        ),
                        child: Text(
                          libraryModel.type!,
                          style: TextStyle(
                            color: Utils.lightGrey,
                            fontSize: SizeConfig.safeBlockHorizontal * 3.5,
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
      ),
    );
  }

  Widget getBookItem(int index) {
    return Container(
      margin: EdgeInsets.only(
        left: SizeConfig.safeBlockHorizontal * 2,
        right: SizeConfig.safeBlockHorizontal * 2,
        bottom: SizeConfig.safeBlockHorizontal * 3,
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
              right: SizeConfig.safeBlockHorizontal * 3.5,
            ),
            child: Container(
              height: SizeConfig.screenHeight / 5.5,
              child: Row(
                children: [
                  Container(
                    height: SizeConfig.screenHeight / 5.5,
                    width: SizeConfig.screenWidth / 4,
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
                            fontSize: SizeConfig.baseFontSize * 4,
                          ),
                          top: SizeConfig.safeBlockVertical * 1,
                          right: SizeConfig.safeBlockHorizontal * 5,
                          left: SizeConfig.safeBlockHorizontal * 3,
                        ),
                        Utils().getWithPadding(
                          Utils().getText(
                            _libraryScreenController.booksDataList[index].authorName,
                            color: Utils.grey,
                            fontSize: SizeConfig.baseFontSize * 3.2,
                          ),
                          left: SizeConfig.safeBlockHorizontal * 3,
                          right: SizeConfig.safeBlockHorizontal * 3,
                          bottom: SizeConfig.safeBlockHorizontal * 2,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Utils.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          margin: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 3,
                          ),
                          child: Utils().getWithPadding(
                            Utils().getText(
                              "Quantity: " + _libraryScreenController.booksDataList[index].quantity.toString(),
                              color: Utils.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.baseFontSize * 2.9,
                            ),
                            top: SizeConfig.safeBlockVertical * 0.3,
                            bottom: SizeConfig.safeBlockVertical * 0.3,
                            left: SizeConfig.safeBlockHorizontal * 2,
                            right: SizeConfig.safeBlockHorizontal * 2,
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
                                fontSize: SizeConfig.baseFontSize * 3.2,
                              ),
                              top: SizeConfig.safeBlockVertical * 1,
                              left: SizeConfig.safeBlockHorizontal * 3,
                            ),
                            Utils().getWithPadding(
                              Utils().getText(
                                "Security: " + _libraryScreenController.booksDataList[index].percentSecurity.toString() + "%",
                                color: Utils.primaryColor,
                                fontSize: SizeConfig.baseFontSize * 3.2,
                              ),
                              top: SizeConfig.safeBlockVertical * 1,
                              right: SizeConfig.safeBlockHorizontal * 2,
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
                            left: SizeConfig.safeBlockHorizontal * 3,
                            bottom: SizeConfig.safeBlockVertical * 1,
                          ),
                          child: Utils().getWithPadding(
                            Utils().getText(
                              _libraryScreenController.booksDataList[index].category ?? "Category",
                              fontSize: SizeConfig.baseFontSize * 3.0,
                            ),
                            top: SizeConfig.safeBlockVertical * 0.2,
                            bottom: SizeConfig.safeBlockVertical * 0.2,
                            left: SizeConfig.safeBlockHorizontal * 2,
                            right: SizeConfig.safeBlockHorizontal * 2,
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
                      size: SizeConfig.iconExamHeightAndWidth * 0.5,
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
                      size: SizeConfig.iconExamHeightAndWidth * 0.5,
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
