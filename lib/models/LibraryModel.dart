class LibraryModel {
  String? libraryName;
  String? city;
  String? libraryImage;
  String? type;

  LibraryModel({
    this.libraryName,
    this.city,
    this.libraryImage,
    this.type,
  });

  LibraryModel.fromJson(Map<String, dynamic> json) {
    libraryName = json['name'];
    city = json['city'];
    libraryImage = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.libraryName;
    data['city'] = this.city;
    data['image'] = this.libraryImage;
    data['type'] = this.type;
    return data;
  }
}
