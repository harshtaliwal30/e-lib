import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/Utils/app_ui_constants.dart';
import 'package:e_lib/helper/UIHelper.dart';
import 'package:e_lib/models/LibraryModel.dart';
import 'package:e_lib/screens/LibraryPageScreen.dart';
import 'package:e_lib/services/DatabaseHandler.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<LibraryModel> libraries = [];

  @override
  void initState() {
    super.initState();
    DatabaseHandler().fetchLibraries().then((value) {
      value.docs.forEach((element) {
        LibraryModel libraryModel =
            LibraryModel.fromJson(element.data() as dynamic);
        libraries.add(libraryModel);
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    AppUIConst.initOnStartUp(context);
    return Scaffold(
      backgroundColor: Utils.lightBgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: UIHelper.getAppBarView(
          context,
          "Libraries",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppUIConst.safeBlockHorizontal * 4,
                    ),
                    margin: EdgeInsets.only(
                      left: AppUIConst.safeBlockHorizontal * 2,
                    ),
                    decoration: BoxDecoration(
                      color: Utils.pureWhite,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
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
                          fontSize: AppUIConst.safeBlockHorizontal * 4,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {},
                  child: Container(
                    margin: EdgeInsets.only(
                      right: AppUIConst.safeBlockHorizontal * 2,
                    ),
                    padding: EdgeInsets.only(
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
              itemCount: libraries.length,
              itemBuilder: (BuildContext context, int index) {
                return getLibraryView(
                  index,
                );
              },
            ),
          ],
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
            builder: (context) => LibraryPageScreen(
              libraryModel: libraries[index],
            ),
          ),
        );
      },
      child: Card(
        shadowColor: Utils.aliceBlue,
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
                    imageUrl: libraries[index].libraryImage!,
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
                        libraries[index].libraryName!,
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
                        libraries[index].city!,
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
                        libraries[index].type!,
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
