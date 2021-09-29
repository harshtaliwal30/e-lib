class UserModel {
  String? userId;
  String? userName;
  String? userImage;
  String? userPhone;
  String? userEmail;

  UserModel({
    this.userId,
    this.userName,
    this.userImage,
    this.userPhone,
    this.userEmail,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    userImage = json['userImage'];
    userPhone = json['userPhone'];
    userEmail = json['userEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['userPhone'] = this.userPhone;
    data['userEmail'] = this.userEmail;
    return data;
  }
}
