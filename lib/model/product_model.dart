class ProductModel {
  String? productId, name, description, image, price, oldPrice;

  ProductModel(
      {this.productId,
      this.name,
      this.description,
      this.image,
      this.oldPrice,
      this.price});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'productId': productId,
      'oldPrice': oldPrice,
    };
  }

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    name = map['name'];
    description = map['description'];
    image = map['image'];
    price = map['price'];
    oldPrice = map['oldPrice'];
    productId = map['productId'];
  }
}
