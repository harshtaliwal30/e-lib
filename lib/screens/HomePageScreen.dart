import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_lib/Utils/DatabaseHandler.dart';
import 'package:e_lib/Utils/SizeConfig.dart';
import 'package:e_lib/Utils/Utils.dart';
import 'package:e_lib/helper/UIHelper.dart';
import 'package:e_lib/models/LibraryModel.dart';
import 'package:e_lib/screens/LibraryPageScreen.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
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
    SizeConfig().init(context);
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
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal * 4,
                    ),
                    margin: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 2,
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
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
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
                      right: SizeConfig.safeBlockHorizontal * 2,
                    ),
                    padding: EdgeInsets.only(
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
          left: SizeConfig.safeBlockHorizontal * 2,
          right: SizeConfig.safeBlockHorizontal * 2,
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
                        left: SizeConfig.safeBlockHorizontal * 3,
                        top: SizeConfig.safeBlockHorizontal * 4,
                      ),
                      child: Text(
                        libraries[index].libraryName!,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                          color: Utils.black,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 3,
                        top: SizeConfig.safeBlockHorizontal * 1,
                      ),
                      child: Text(
                        libraries[index].city!,
                        style: TextStyle(
                          color: Utils.black,
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 3,
                        bottom: SizeConfig.safeBlockHorizontal * 2,
                      ),
                      child: Text(
                        libraries[index].type!,
                        style: TextStyle(
                          color: Utils.black,
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
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
