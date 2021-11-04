import 'package:e_lib/Utils/app_routes.dart';
import 'package:e_lib/Utils/size_config.dart';
import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/controllers/home_screen_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatelessWidget {
  final HomeScreenController _homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Utils.blue,
                    // backgroundImage: NetworkImage(
                    //   "https://firebasestorage.googleapis.com/v0/b/e-lib-e53d6.appspot.com/o/28828394_950086555154619_9137006216337597187_o.jpg?alt=media&token=dd2c5145-1e19-43d6-ace7-6bede86f7a7d",
                    // ),
                  ),
                  Utils().getWithPadding(
                    Utils().getText(
                      "Harsh Taliwal",
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.baseFontSize * 4,
                    ),
                    top: SizeConfig.safeBlockVertical * 1,
                  ),
                  Utils().getText(
                    "Aligarh",
                    color: Utils.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.baseFontSize * 3.5,
                  )
                ],
              ),
              decoration: BoxDecoration(),
            ),
            SizedBox(height: 10),
            getDrawerItem(
              "Home",
              Icons.home,
              AppRoutes.homeScreenRoute,
              () => {
                Get.back(),
                AppRoutes.moveOffAllScreen(
                  AppRoutes.homeScreenRoute,
                )
              },
            ),
            getDrawerItem(
              "Profile",
              Icons.person,
              "/issueRequestsScreen",
              () => {
                // Get.back(),
                // AppRoutes.moveToScreen(
                //   "/issueRequestsScreen",
                // )
              },
            ),
            getDrawerItem(
              "Requests",
              Icons.notifications_on_outlined,
              AppRoutes.issueRequestsRoute,
              () => {
                Get.back(),
                AppRoutes.moveToScreen(
                  AppRoutes.issueRequestsRoute,
                )
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Utils().getChipView(
                  //   _homeScreenController.pendingRequestsCount.toString(),
                  //   color: Utils.amber,
                  // ),
                  // SizedBox(width: 6),
                  Utils().getChipView(
                    _homeScreenController.approvedRequestsCount.toString(),
                    color: Utils.green,
                  ),
                  SizedBox(width: 8),
                  Utils().getChipView(
                    _homeScreenController.declinedRequestsCount.toString(),
                    color: Utils.red,
                  )
                ],
              ),
            ),
            getDrawerItem(
              "Issued Books",
              Icons.book_rounded,
              AppRoutes.issuedBooksRoute,
              () => {
                Get.back(),
                AppRoutes.moveToScreen(
                  AppRoutes.issuedBooksRoute,
                )
              },
            ),
            getDrawerItem(
              "Returned Books",
              Icons.book_rounded,
              AppRoutes.returnedBooksRoute,
              () => {
                Get.back(),
                AppRoutes.moveToScreen(
                  AppRoutes.returnedBooksRoute,
                )
              },
            ),
            getDrawerItem(
              "Contact Us",
              Icons.phone,
              "/issueRequestsScreen",
              () => {
                // Get.back(),
                // AppRoutes.moveToScreen(
                //   "/issueRequestsScreen",
                // )
              },
            ),
            getDrawerItem(
              "Logout",
              Icons.logout_rounded,
              "/loginScreen",
              () => {
                Get.back(),
                SharedPreferences.getInstance().then((onValue) {
                  onValue.setBool(Utils.KEY_ISLOGIN, false);
                  FirebaseAuth.instance.signOut();
                  AppRoutes.moveOffAllScreen(AppRoutes.loginScreenRoute);
                }),
              },
              color: Utils.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget getDrawerItem(
    String title,
    IconData leadingIcon,
    String route,
    Function()? onTap, {
    Color color = Utils.grey,
    Widget? trailing,
  }) {
    return Utils().getWithPadding(
      ListTile(
        leading: Icon(
          leadingIcon,
          color: Get.currentRoute == route ? Utils.white : color,
        ),
        trailing: trailing,
        horizontalTitleGap: 0.0,
        title: Utils().getText(
          title,
          color: Get.currentRoute == route ? Utils.white : color,
          fontWeight: Get.currentRoute == route ? FontWeight.bold : FontWeight.normal,
        ),
        tileColor: Get.currentRoute == route ? Utils.blue : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        onTap: onTap,
      ),
      left: SizeConfig.safeBlockHorizontal * 3,
      right: SizeConfig.safeBlockHorizontal * 3,
    );
  }
}
