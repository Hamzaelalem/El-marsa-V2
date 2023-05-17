class CategorieModel {
  late String? name, image;
  //late List<String?> ProductId;
  CategorieModel({
    this.name,
    //required this.ProductId,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      //'ProductId':ProductId,
    };
  }

  CategorieModel.fromJason(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
   // ProductId = map['ProductId'];
    name = map['name'];
    image = map['image'];
  }
}
