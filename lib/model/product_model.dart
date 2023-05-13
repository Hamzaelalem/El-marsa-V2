//import 'dart:html';

import 'package:image_picker/image_picker.dart';

class ProductModel {
  String? productId,
      name,
      description,
      image,
      price,
      oldPrice,
      stock,
      ar,
      fournisseurName,
      founisseurId;
  XFile? imageFile;
  ProductModel(
      {this.productId,
      this.name,
      this.description,
      this.image,
      this.oldPrice,
      this.price,
      this.stock,
      this.founisseurId,
      this.fournisseurName,
      this.ar,
      this.imageFile});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ar': ar,
      'description': description,
      'image': image,
      'price': price,
      'productId': productId,
      'oldPrice': oldPrice,
      'founisseurId': founisseurId,
      'fournisseurName': fournisseurName,
      'imageFile': imageFile,
    };
  }

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    name = map['name'];
    ar = map['ar'];
    description = map['description'];
    image = map['image'];
    price = map['price'];
    oldPrice = map['oldPrice'];
    productId = map['productId'];
    founisseurId = map['founisseurId'];
    fournisseurName = map['fournisseurName'];
    imageFile = map['imageFile'];
  }
}
