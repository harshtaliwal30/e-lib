import 'package:e_lib/Utils/SizeConfig.dart';
import 'package:e_lib/Utils/Utils.dart';
import 'package:e_lib/helper/UIHelper.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Utils.pureWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: UIHelper.getAppBarView(
          context,
          "Libraries",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
