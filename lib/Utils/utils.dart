import 'package:flutter/material.dart';

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
      ),
    );
  }
}
