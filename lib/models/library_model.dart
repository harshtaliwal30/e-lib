class LibraryModel {
  String? libraryName;
  String? city;
  String? libraryImage;
  String? type;
  String? address;
  String? libraryEmail;
  String? libraryPhone;
  String? libraryId;

  LibraryModel({
    this.libraryName,
    this.city,
    this.libraryImage,
    this.type,
    this.address,
    this.libraryEmail,
    this.libraryPhone,
    this.libraryId,
  });

  LibraryModel.fromJson(Map<String, dynamic> json) {
    libraryName = json['libraryName'];
    city = json['city'];
    libraryImage = json['libraryImage'];
    type = json['type'];
    address = json['address'];
    libraryEmail = json['libraryEmail'];
    libraryPhone = json['libraryPhone'];
    libraryId = json['libraryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['libraryName'] = this.libraryName;
    data['city'] = this.city;
    data['libraryImage'] = this.libraryImage;
    data['type'] = this.type;
    data['address'] = this.address;
    data['libraryEmail'] = this.libraryEmail;
    data['libraryPhone'] = this.libraryPhone;
    data['libraryId'] = this.libraryId;
    return data;
  }
}
