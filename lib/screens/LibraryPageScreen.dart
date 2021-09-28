import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_lib/Utils/Utils.dart';
import 'package:e_lib/Utils/app_ui_constants.dart';
import 'package:e_lib/helper/UIHelper.dart';
import 'package:e_lib/models/LibraryModel.dart';
import 'package:flutter/material.dart';

class LibraryPageScreen extends StatefulWidget {
  const LibraryPageScreen({
    Key? key,
    required this.libraryModel,
  }) : super(key: key);

  final LibraryModel libraryModel;

  @override
  _LibraryPageScreenState createState() => _LibraryPageScreenState();
}

class _LibraryPageScreenState extends State<LibraryPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.pureWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: UIHelper.getAppBarView(
          context,
          widget.libraryModel.libraryName!,
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
                          imageUrl: widget.libraryModel.libraryImage!,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: AppUIConst.safeBlockHorizontal * 2,
                        top: AppUIConst.safeBlockHorizontal * 4,
                      ),
                      child: Text(
                        widget.libraryModel.libraryName!,
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
                        widget.libraryModel.type!,
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
                        widget.libraryModel.city!,
                        style: TextStyle(
                          color: Utils.black,
                          fontSize: AppUIConst.safeBlockHorizontal * 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
