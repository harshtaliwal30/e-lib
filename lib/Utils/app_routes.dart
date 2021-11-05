import 'package:e_lib/screens/home_screen.dart';
import 'package:e_lib/screens/issue_requests_screen.dart';
import 'package:e_lib/screens/issued_books_screen.dart';
import 'package:e_lib/screens/library_screen.dart';
import 'package:e_lib/screens/login_screen.dart';
import 'package:e_lib/screens/otp_screen.dart';
import 'package:e_lib/screens/profile_screen.dart';
import 'package:e_lib/screens/returned_books_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splashScreenRoute = "/splashScreen";
  static const String homeScreenRoute = "/homeScreen";
  static const String loginScreenRoute = "/loginScreen";
  static const String otpScreenRoute = "/otpScreen";
  static const String libraryScreenRoute = "/libraryScreen";
  static const String issuedBooksRoute = "/issuedBooksScreen";
  static const String returnedBooksRoute = "/returnedBooksScreen";
  static const String issueRequestsRoute = "/issueRequestsScreen";
  static const String profileRoute = "/profileScreen";

  static routes() {
    GetPage<dynamic> _page(String route, var page) {
      return GetPage(name: route, page: page);
    }

    return [
      _page(homeScreenRoute, () => HomeScreen()),
      _page(loginScreenRoute, () => LoginScreen()),
      _page(otpScreenRoute, () => OTPScreen()),
      _page(issuedBooksRoute, () => IssuedBooksScreen()),
      _page(returnedBooksRoute, () => ReturnedBooksScreen()),
      _page(issueRequestsRoute, () => IssueRequestsScreen()),
      _page(profileRoute, () => ProfileScreen()),
      GetPage(name: libraryScreenRoute, page: () => LibraryScreen(libraryModel: Get.arguments)),
    ];
  }

  static void moveToScreen(String routeName) {
    Get.toNamed(routeName);
  }

  static Future<dynamic> moveToScreenWithArguments(String routeName, {@required var arguments}) async {
    return await Get.toNamed(routeName, arguments: arguments);
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
