import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_lib/Utils/DatabaseHandler.dart';
import 'package:e_lib/Utils/SizeConfig.dart';
import 'package:e_lib/Utils/Utils.dart';
import 'package:e_lib/helper/UIHelper.dart';
import 'package:e_lib/models/LibraryModel.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<Color> colors = [
    Color(0XFFFE8A65),
    Color(0XFF30AC70),
    Color(0XFF566E7A),
    Color(0XFF0177BB)
  ];
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
      backgroundColor: Utils.pureWhite,
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
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
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
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        side: BorderSide(
          color: Utils.greyLight,
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
              width: 100,
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
                        fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 3,
                      // top: SizeConfig.safeBlockHorizontal * 4,
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
    );
  }
}
