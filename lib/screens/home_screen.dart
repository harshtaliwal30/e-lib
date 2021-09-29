import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/Utils/app_ui_constants.dart';
import 'package:e_lib/controllers/home_screen_controller.dart';
import 'package:e_lib/screens/library_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController _homePageController = Get.put(HomeScreenController());

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
          'Libraries',
          color: Utils.primaryColor,
          fontSize: AppUIConst.baseFontSize * 4.5,
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(
                        left: AppUIConst.safeBlockHorizontal * 4,
                      ),
                      child: TextField(
                        autofocus: false,
                        onSubmitted: (value) {
                          // if (value.length > 3) {
                          //   setState(() {
                          //     recentSearchList.add(value);
                          //     savedRecentSearch(value);
                          //   });
                          //   preformSearch(value);
                          // }
                        },
                        decoration: InputDecoration(
                          hintText: 'Search for libraries',
                          hintStyle: TextStyle(
                            fontSize: AppUIConst.baseFontSize * 3.5,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {},
                    child: Container(
                      margin: EdgeInsets.only(
                        right: AppUIConst.safeBlockHorizontal * 4,
                        left: AppUIConst.safeBlockHorizontal * 4,
                      ),
                      child: Icon(Icons.search),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: AppUIConst.safeBlockHorizontal * 6,
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _homePageController.librariesDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return getLibraryView(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getLibraryView(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LibraryScreen(
              libraryModel: _homePageController.librariesDataList[index],
            ),
          ),
        );
      },
      child: Card(
        shadowColor: Utils.blue,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          side: BorderSide(
            color: Utils.black,
            width: 0.5,
          ),
        ),
        margin: EdgeInsets.only(
          left: AppUIConst.safeBlockHorizontal * 2,
          right: AppUIConst.safeBlockHorizontal * 2,
          bottom: AppUIConst.safeBlockHorizontal * 2,
        ),
        child: Container(
          padding: EdgeInsets.all(
            AppUIConst.safeBlockHorizontal * 2,
          ),
          height: AppUIConst.screenHeight / 6,
          child: Row(
            children: [
              Container(
                height: AppUIConst.screenHeight / 6,
                width: AppUIConst.screenWidth / 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: _homePageController.librariesDataList[index].libraryImage ?? "",
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: AppUIConst.safeBlockHorizontal * 3,
                        top: AppUIConst.safeBlockHorizontal * 4,
                      ),
                      child: Text(
                        _homePageController.librariesDataList[index].libraryName ?? "",
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                          color: Utils.black,
                          fontWeight: FontWeight.bold,
                          fontSize: AppUIConst.safeBlockHorizontal * 4.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: AppUIConst.safeBlockHorizontal * 3,
                        top: AppUIConst.safeBlockHorizontal * 1,
                      ),
                      child: Text(
                        _homePageController.librariesDataList[index].city ?? "",
                        style: TextStyle(
                          color: Utils.black,
                          fontSize: AppUIConst.safeBlockHorizontal * 4,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        left: AppUIConst.safeBlockHorizontal * 3,
                        bottom: AppUIConst.safeBlockHorizontal * 2,
                      ),
                      child: Text(
                        _homePageController.librariesDataList[index].type ?? "",
                        style: TextStyle(
                          color: Utils.black,
                          fontSize: AppUIConst.safeBlockHorizontal * 4,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
