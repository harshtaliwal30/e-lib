import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/Utils/size_config.dart';
import 'package:e_lib/controllers/home_screen_controller.dart';
import 'package:e_lib/screens/drawer_screen.dart';
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
    SizeConfig.initOnStartUp(context);
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
          fontSize: SizeConfig.baseFontSize * 4.5,
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
                        left: SizeConfig.safeBlockHorizontal * 4,
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
                            fontSize: SizeConfig.baseFontSize * 3.5,
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
                        right: SizeConfig.safeBlockHorizontal * 4,
                        left: SizeConfig.safeBlockHorizontal * 4,
                      ),
                      child: Icon(Icons.search),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockHorizontal * 6,
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
      drawer: DrawerScreen(),
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
        shadowColor: Utils.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        margin: EdgeInsets.only(
          left: SizeConfig.safeBlockHorizontal * 4,
          right: SizeConfig.safeBlockHorizontal * 4,
          bottom: SizeConfig.safeBlockHorizontal * 2,
        ),
        child: Container(
          padding: EdgeInsets.all(
            SizeConfig.safeBlockHorizontal * 2,
          ),
          height: SizeConfig.screenHeight / 6,
          child: Row(
            children: [
              Container(
                height: SizeConfig.screenHeight / 6,
                width: SizeConfig.screenWidth / 4,
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
                        left: SizeConfig.safeBlockHorizontal * 3,
                      ),
                      child: Utils().getText(
                        _homePageController.librariesDataList[index].libraryName ?? "",
                        color: Utils.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.baseFontSize * 4,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 3,
                        top: SizeConfig.safeBlockHorizontal * 1,
                      ),
                      child: Text(
                        _homePageController.librariesDataList[index].address +
                            ", " +
                            _homePageController.librariesDataList[index].city +
                            ", " +
                            _homePageController.librariesDataList[index].state +
                            ", " +
                            _homePageController.librariesDataList[index].country,
                        style: TextStyle(
                          color: Utils.primaryColor,
                          fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 3,
                      ),
                      child: Text(
                        _homePageController.librariesDataList[index].type ?? "",
                        style: TextStyle(
                          color: Utils.darkGrey,
                          fontSize: SizeConfig.safeBlockHorizontal * 3.8,
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
