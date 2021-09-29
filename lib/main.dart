import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/Utils/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Utils.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Lib',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.white70,
        fontFamily: "OpenSans",
      ),
      getPages: AppRoutes.routes(),
      initialRoute: AppRoutes.loginScreenRoute,
    );
  }
}
