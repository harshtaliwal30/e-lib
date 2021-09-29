import 'package:e_lib/screens/home_screen.dart';
import 'package:e_lib/screens/login_screen.dart';
import 'package:e_lib/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splashScreenRoute = "/splashScreen";
  static const String homeScreenRoute = "/homeScreen";
  static const String loginScreenRoute = "/loginScreen";
  static const String otpScreenRoute = "/otpScreen";

  static routes() {
    GetPage<dynamic> _page(String route, var page) {
      return GetPage(name: route, page: page);
    }

    return [
      _page(homeScreenRoute, () => HomeScreen()),
      _page(loginScreenRoute, () => LoginScreen()),
      _page(loginScreenRoute, () => OTPScreen()),
      // GetPage(name: loginRoute, page: () => LoginScreen()),
      // GetPage(
      //     name: homeitemviewRoute,
      //     page: () => HomeItemView(homeItemViewScreenModel: Get.arguments)),
    ];
  }

  static void moveToScreen(String routeName) {
    Get.toNamed(routeName);
  }

  static void moveToScreenWithArguments(String routeName, {@required var arguments}) {
    Get.toNamed(routeName, arguments: arguments);
  }

  static void moveOffScreen(String routeName) {
    Get.offNamed(routeName);
  }

  static void moveOffAllScreen(String routeName) {
    Get.offAllNamed(routeName);
  }

  static void moveOffAllScreenWithArguments(String routeName, {@required var arguments}) {
    Get.offAll(routeName, arguments: arguments);
  }
}
