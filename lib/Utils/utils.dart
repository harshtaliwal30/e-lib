import 'package:e_lib/Utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static const white = Colors.white;
  static const black = Colors.black;
  static const grey = Colors.grey;
  static const purple = Colors.purple;
  static const lightBgColor = Color(0XFFEFF3F6);
  static const red = Colors.red;
  static const green = Color(0xFF66B032);
  static const lightGrey = Color(0xFFE0E0E0);
  static const darkGrey = Color(0XFF5b5b5b);
  static const errorColor = Color(0xFFFF0000);
  static const blue = Color(0xFF7894FF);
  static const primaryColor = Color(0XFF2C3848);
  static const whip = Color(0XFFF8E8CF);
  static const amber = Color(0XFFFFC500);

  static const String KEY_ISLOGIN = "isLogin";
  static const String KEY_USERID = "userId";
  static const String KEY_USERNAME = "userName";
  static const String KEY_USEREMAIL = "userEmail";
  static const String KEY_USERPHONE = "userPhone";
  static const String KEY_USERIMAGE = "userImage";

  void showWarningSnackbar(String msg) {
    Get.snackbar(
      "Warning",
      msg,
      backgroundColor: Utils.whip,
      borderRadius: 5.0,
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.safeBlockVertical * 1,
      ),
      duration: Duration(milliseconds: 1000),
      icon: Icon(Icons.warning_amber_rounded),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(
        bottom: SizeConfig.safeBlockVertical * 2,
        left: SizeConfig.safeBlockHorizontal * 3,
        right: SizeConfig.safeBlockHorizontal * 3,
      ),
    );
  }

  void showConfirmSnackbar(String msg) {
    Get.snackbar(
      "Success",
      msg,
      backgroundColor: Utils.green,
      borderRadius: 5.0,
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.safeBlockVertical * 1,
      ),
      colorText: Utils.white,
      duration: Duration(milliseconds: 2000),
      icon: Icon(
        Icons.emoji_emotions_rounded,
        color: Utils.white,
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(
        bottom: SizeConfig.safeBlockVertical * 2,
        left: SizeConfig.safeBlockHorizontal * 3,
        right: SizeConfig.safeBlockHorizontal * 3,
      ),
    );
  }

  Future<dynamic> showDialog(
    String title,
    String msg,
    Function()? onConfirm,
  ) async {
    return await Get.defaultDialog(
      title: title,
      middleText: msg,
      barrierDismissible: false,
      radius: 10,
      buttonColor: Utils.primaryColor,
      onCancel: null,
      onConfirm: onConfirm,
      textCancel: "No",
      textConfirm: "Yes",
      cancelTextColor: Utils.primaryColor,
      confirmTextColor: Utils.white,
    );
  }

  Future<dynamic> showLoader() async {
    return await Get.defaultDialog(
      title: "Loading...",
      titleStyle: TextStyle(fontSize: SizeConfig.baseFontSize * 4),
      radius: 10,
      content: Container(height: 30, width: 30, child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
  }

  Padding getWithPadding(
    Widget child, {
    double left = 0.0,
    right = 0.0,
    top = 0.0,
    bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: child,
    );
  }

  Text getText(
    String content, {
    Color color = Utils.primaryColor,
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Text(
      content,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget getChipView(
    String value, {
    Color color = Utils.red,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.safeBlockHorizontal * 2,
        vertical: SizeConfig.safeBlockVertical * 0.05,
      ),
      child: Utils().getText(
        value,
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: SizeConfig.baseFontSize * 2.9,
      ),
    );
  }
}
