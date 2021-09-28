import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/Utils/app_ui_constants.dart';
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
          fontSize: AppUIConst.safeBlockHorizontal * 4.5,
        ),
      ),
    );
  }
}
