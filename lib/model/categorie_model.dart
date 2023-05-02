class CategorieModel {
  late String? name, image;
  CategorieModel({this.name, this.image});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }

  CategorieModel.fromJason(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    name = map['name'];
    image = map['image'];
  }
}
