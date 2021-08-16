import 'package:e_lib/Utils/SizeConfig.dart';
import 'package:e_lib/Utils/Utils.dart';
import 'package:flutter/material.dart';

class UIHelper {
  static Widget getAppBarView(
    BuildContext context,
    String title, {
    Color bgColor = Utils.lightBgColor,
  }) {
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      titleSpacing: 5,
      backgroundColor: bgColor,
      iconTheme: IconThemeData(
        color: Utils.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Utils.black,
          fontSize: SizeConfig.safeBlockHorizontal * 4.5,
        ),
      ),
    );
  }
}
