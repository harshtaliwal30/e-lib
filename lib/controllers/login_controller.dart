import 'dart:async';
import 'package:e_lib/Utils/app_routes.dart';
import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/models/user_model.dart';
import 'package:e_lib/services/database_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController otpController = new TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Timer timer = Timer(Duration(seconds: 0), () {});
  var seconds = 60.obs;
  String? verificationID;

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds.value == 0) {
        timer.cancel();
      } else {
        seconds--;
      }
    });
  }

  sendOTPMsg() async {
    Utils().showLoader();
    _auth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneController.text,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        print("calling verification completed");
        UserCredential result = await _auth.signInWithCredential(credential);
        User? user = result.user;
        if (user != null) {
          await addUser();
        } else {
          print("Error");
        }
        //This callback would gets called when verification is done automatically
      },
      verificationFailed: (Exception exception) {
        Utils().showWarningSnackbar("Please enter valid OTP");
        print("Exception - $exception");
      },
      codeSent: (String verificationId, [int? forceResendingToken]) {
        print("code send - $verificationId");

        Get.back();
        startTimer();
        this.verificationID = verificationId;
      },
      codeAutoRetrievalTimeout: (String verId) {
        Get.back();
        startTimer();
        otpController.clear();
        Utils().showWarningSnackbar("Something went wrong. Check your internet connection");
        print("Exception - TIMEOUT");
      },
    );
  }

  checkOTP() async {
    if (otpController.text.length == 6) {
      if (verificationID != null) {
        Utils().showLoader();
        AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: this.verificationID!,
          smsCode: otpController.text,
        );
        UserCredential userCred = await _auth.signInWithCredential(credential).catchError((onError) {
          Get.back();
          Utils().showWarningSnackbar("Please enter valid OTP");
        });
        if (userCred.user != null) {
          Get.back();
          await addUser();
        } else {
          Get.back();
          Utils().showWarningSnackbar("Something went wrong");
        }
      } else {
        Get.back();
        Utils().showWarningSnackbar("Something went wrong. Please check the google play services and try again.");
      }
    } else {
      Utils().showWarningSnackbar("Please enter valid OTP");
    }
  }

  addUser() async {
    await DatabaseHandler().checkUserAvailableUsingPhone("+91" + phoneController.text).then((value) async {
      if (value.docs.length > 0) {
        ///If the user has registered
        value.docs.forEach((docSnap) async {
          var userData = docSnap.data() as dynamic;
          UserModel userModel = UserModel.fromJson(userData);
          SharedPreferences.getInstance().then((pref) {
            pref.setString(Utils.KEY_USERNAME, userModel.userName == null ? "" : userModel.userName!);
            pref.setString(Utils.KEY_USERIMAGE, userModel.userImage == null ? "" : userModel.userImage!);
            pref.setString(Utils.KEY_USEREMAIL, userModel.userEmail == null ? "" : userModel.userEmail!);
            pref.setString(Utils.KEY_USERPHONE, userModel.userPhone == null ? "" : userModel.userPhone!);
            pref.setString(Utils.KEY_USERID, docSnap.id);
            pref.setBool(Utils.KEY_ISLOGIN, true);
            Get.back();
            AppRoutes.moveOffAllScreen(AppRoutes.homeScreenRoute);
          });
        });
      } else {
        ///If the user has NOT yet registered
        SharedPreferences.getInstance().then((pref) async {
          UserModel _userModel = UserModel(
            userName: null,
            userImage: null,
            userEmail: null,
            userPhone: "+91" + phoneController.text,
          );
          var data = _userModel.toJson();
          String? userId = await DatabaseHandler().addUser(data);
          pref.setBool(Utils.KEY_ISLOGIN, true);
          pref.setString(Utils.KEY_USERID, userId!);
          pref.setString(Utils.KEY_USERPHONE, phoneController.text);
          AppRoutes.moveOffAllScreen(AppRoutes.homeScreenRoute);
        });
      }
    }).catchError((onError) {
      print("Error - " + onError);
    });
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
}
