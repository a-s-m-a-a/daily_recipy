class ImagesData {
  String? title;
  String? imagePath;
  ImagesData();
  ImagesData.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    imagePath = data['imagepath'];
  }
  Map<String, dynamic> toJson() {
    return {"title": title, "imagePath": imagePath};
  }
}
