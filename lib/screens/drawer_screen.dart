import 'package:e_lib/Utils/app_routes.dart';
import 'package:e_lib/Utils/size_config.dart';
import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/controllers/home_screen_controller.dart';
import 'package:e_lib/controllers/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatelessWidget {
  final HomeScreenController _homeScreenController = Get.find<HomeScreenController>();
  final ProfileController _profileController = Get.put(ProfileController());

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
                    backgroundImage: _profileController.userModel.userImage != null
                        ? NetworkImage(
                            _profileController.userModel.userImage!,
                          )
                        : null,
                  ),
                  Utils().getWithPadding(
                    Utils().getText(
                      _profileController.userModel.userName ?? "",
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.baseFontSize * 4,
                    ),
                    top: SizeConfig.safeBlockVertical * 1,
                  ),
                  Utils().getText(
                    _profileController.userModel.city ?? "",
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
              Icons.home_rounded,
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
              Icons.person_rounded,
              AppRoutes.profileRoute,
              () => {
                Get.back(),
                AppRoutes.moveToScreen(
                  AppRoutes.profileRoute,
                )
              },
            ),
            getDrawerItem(
              "Requests",
              Icons.notifications_on_rounded,
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
              Icons.bookmark_added_rounded,
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
              Icons.phone_rounded,
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
              AppRoutes.loginScreenRoute,
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
