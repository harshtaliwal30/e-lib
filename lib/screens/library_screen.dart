import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/Utils/size_config.dart';
import 'package:e_lib/controllers/library_screen_controller.dart';
import 'package:e_lib/controllers/profile_controller.dart';
import 'package:e_lib/models/library_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LibraryScreen extends StatelessWidget {
  final LibraryModel libraryModel;
  LibraryScreen({required this.libraryModel});

  final LibraryScreenController _libraryScreenController = Get.put(LibraryScreenController());
  final ProfileController _profileController = Get.find<ProfileController>();

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            // imageUrl: libraryModel.libraryImage!,
                            imageUrl:
                                "https://firebasestorage.googleapis.com/v0/b/e-lib-e53d6.appspot.com/o/28828394_950086555154619_9137006216337597187_o.jpg?alt=media&token=dd2c5145-1e19-43d6-ace7-6bede86f7a7d",
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
              Utils().getWithPadding(
                Utils().getText(
                  "All Books",
                  fontWeight: FontWeight.bold,
                ),
                left: SizeConfig.safeBlockHorizontal * 3.5,
                top: SizeConfig.safeBlockVertical * 2,
                bottom: SizeConfig.safeBlockVertical * 2,
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
    return Card(
      shadowColor: Utils.white,
      elevation: 15,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: EdgeInsets.only(
        left: SizeConfig.safeBlockHorizontal * 3,
        right: SizeConfig.safeBlockHorizontal * 3,
        bottom: SizeConfig.safeBlockHorizontal * 3,
      ),
      child: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight / 5.5,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 3),
                  child: Container(
                    height: SizeConfig.screenHeight / 6.5,
                    width: SizeConfig.screenWidth / 3.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl:
                            "https://firebasestorage.googleapis.com/v0/b/e-lib-e53d6.appspot.com/o/28828394_950086555154619_9137006216337597187_o.jpg?alt=media&token=dd2c5145-1e19-43d6-ace7-6bede86f7a7d",
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
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
                        right: SizeConfig.safeBlockHorizontal * 3,
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal * 2,
                            vertical: SizeConfig.safeBlockVertical * 0.2,
                          ),
                          child: Utils().getText(
                            "Quantity: " + _libraryScreenController.booksDataList[index].quantity.toString(),
                            color: Utils.white,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.baseFontSize * 2.9,
                          ),
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal * 2,
                            vertical: SizeConfig.safeBlockVertical * 0.2,
                          ),
                          child: Utils().getText(
                            _libraryScreenController.booksDataList[index].category ?? "Category",
                            fontSize: SizeConfig.baseFontSize * 3.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(
            height: 0,
            color: Utils.grey,
            indent: 10,
            endIndent: 10,
            thickness: 0.5,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal * 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () async {
                      var result = await Utils().showDialog(
                        "Alert",
                        "Are you sure you want to issue this book",
                        () async {
                          await _libraryScreenController.placeIssueRequest(
                              _libraryScreenController.booksDataList[index], libraryModel.libraryId!, _profileController.userModel);
                          Get.back(result: "requestPlaced");
                        },
                      );
                      if (result != null && result == "requestPlaced") {
                        Utils().showConfirmSnackbar("Book Issue Request Placed");
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Utils().getText(
                      "Issue Book",
                      color: Utils.green,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.baseFontSize * 3.5,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
