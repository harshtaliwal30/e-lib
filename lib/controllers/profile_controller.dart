import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:e_lib/Utils/cloudinary_manager.dart';
import 'package:e_lib/Utils/size_config.dart';
import 'package:e_lib/Utils/utils.dart';
import 'package:e_lib/models/user_model.dart';
import 'package:e_lib/services/database_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  UserModel userModel = UserModel();
  String? docId = "";
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  var isLoading = true.obs;
  var countryValue = "".obs;
  var stateValue = "".obs;
  var cityValue = "".obs;
  var address = "".obs;
  var imageUrl = "".obs;
  var image = File("").obs;

  @override
  void onInit() {
    isLoading(true);
    fetchUserData();
    super.onInit();
  }

  void fetchUserData() {
    SharedPreferences.getInstance().then((pref) {
      docId = pref.getString(Utils.KEY_USERID);
      DatabaseHandler().fetchUserData(docId!).then((value) {
        Map<String, dynamic> docData = value.data() as dynamic;
        docData["userId"] = value.id;
        userModel = UserModel.fromJson(docData);
        userNameController.text = userModel.userName ?? "";
        userEmailController.text = userModel.userEmail ?? "";
        userPhoneController.text = userModel.userPhone!;
        imageUrl.value = userModel.userImage ?? "";
        addressController.text = userModel.address ?? "";
        countryValue.value = userModel.country ?? "";
        stateValue.value = userModel.state ?? "";
        cityValue.value = userModel.city ?? "";
        isLoading(false);
        update();
      });
    });
  }

  Future<void> updateUserData() async {
    UserModel _userModel = new UserModel(
      userName: userNameController.text,
      userEmail: userEmailController.text,
      userPhone: userPhoneController.text,
      userImage: imageUrl.value,
      address: addressController.text,
      country: countryValue.value,
      state: stateValue.value,
      city: cityValue.value,
    );

    var data = _userModel.toJson();
    DatabaseHandler().updateUserData(data, docId).then((value) {
      Get.back();
    });
  }

  uploadProfileImage() async {
    if (image.value.path.length > 0) {
      Get.dialog(
        Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
      dio.FormData formData = new dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(
          image.value.path,
          contentType: new MediaType("image", "jpeg"),
        ),
        "upload_preset": "upload_preset",
        "folder": "User_Profile_Images",
        "cloud_name": "dciyee0g5",
      });
      CloudinaryManager().uploadImage(formData).then((value) {
        imageUrl.value = value;
        Get.back();
        updateUserData();
      });
    } else if (userModel.userImage != null) {
      updateUserData();
    } else {
      Utils().showWarningSnackbar("Please select profile image");
    }
  }

  _imgFromCamera() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    imageUrl.value = "";
    file != null ? image.value = File(file.path) : image.value = File("");
  }

  _imgFromGallery() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    imageUrl.value = "";
    file != null ? image.value = File(file.path) : image.value = File("");
  }

  Future<dynamic> openPickerOptions() {
    return Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 2),
        child: new Wrap(
          children: <Widget>[
            new ListTile(
              leading: new Icon(
                Icons.photo_library,
                color: Utils.white,
              ),
              title: Utils().getText(
                "Photo Library",
                color: Utils.white,
              ),
              onTap: () {
                _imgFromGallery();
                Get.back();
              },
            ),
            Divider(
              color: Utils.white,
              height: 0,
            ),
            new ListTile(
              leading: new Icon(
                Icons.photo_camera,
                color: Utils.white,
              ),
              title: Utils().getText(
                "Camera",
                color: Utils.white,
              ),
              onTap: () {
                _imgFromCamera();
                Get.back();
              },
            ),
            if (image.value.path.length > 0) ...[
              Divider(
                color: Utils.white,
                height: 0,
              ),
              new ListTile(
                leading: new Icon(
                  Icons.hide_image_outlined,
                  color: Utils.white,
                ),
                title: Utils().getText(
                  "Remove",
                  color: Utils.white,
                ),
                onTap: () {
                  image.value = File("");
                  Get.back();
                },
              ),
            ],
          ],
        ),
      ),
      backgroundColor: Utils.primaryColor,
    );
  }

  bool validate() {
    if (countryValue.value.length == 0) {
      Utils().showWarningSnackbar("Please select country");
      return false;
    } else if (stateValue.value.length == 0) {
      Utils().showWarningSnackbar("Please select state");
      return false;
    } else if (cityValue.value.length == 0) {
      Utils().showWarningSnackbar("Please select city");
      return false;
    }
    return true;
  }
}
