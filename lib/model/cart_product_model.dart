class CartProductModel {
  String? productId, name, image, price;
  int? qty;

  CartProductModel(
      {this.productId, this.name, this.image, this.price, this.qty});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'productId': productId,
      'image': image,
      'price': price,
      'qty': qty,
    };
  }

CartProductModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }

    name = map['name'];
    qty = map['qty'];
    image = map['image'];
    price = map['price'];
    productId = map['productId'];
  }

  
}
