import 'cart_product_model.dart';

class PaymentsModel {
  int? createdAt;
  String? amount;
  String? clientId;
  String? clientName;
  String? id;
  List<CartProductModel>? cart;
  String? status;

  PaymentsModel(
      {this.createdAt,
      this.amount,
      this.clientId,
      this.clientName,
      this.id,
      this.cart,
      this.status});

  PaymentsModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    amount = json['amount'];
    clientId = json['clientId'];
    clientName = json['clientName'];
    id = json['id'];
    if (json['cart'] != null) {
      cart = <CartProductModel>[];
      json['cart'].forEach((v) {
        cart!.add(new CartProductModel.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['amount'] = this.amount;
    data['clientId'] = this.clientId;
    data['clientName'] = this.clientName;
    data['id'] = this.id;
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }

  static fromMap(Map<String, dynamic> item) {}
}


// class PaymentsModel {
//   static const ID = "id";
//   static const CLIENT_ID = "clientId";
//   static const CLIENT_NAME = "clientName";
//   static const CART = "cart";
//   static const AMOUNT = "amount";
//   static const STATUS = "status";
//   static const CREATED_AT = "createdAt";

//   String? id;
//   String? clientName;
//   //doube ??
//   String? amount;
//   String? status;
//   int? createdAt;
//   String? clientId;
//   List<CartProductModel>? cart;

//   PaymentsModel({
//     this.id,
//     this.amount,
//     this.status,
//     this.createdAt,
//     this.cart,
//     this.clientId,
//     this.clientName,
//   });

//   // factory PaymentsModel.fromMap(Map<String, dynamic> map) {
//   //   return PaymentsModel(
//   //     id: map[ID],
//   //     amount: map[AMOUNT],
//   //     status: map[STATUS],
//   //     createdAt: map[CREATED_AT],
//   //     clientId: map[CLIENT_ID],
//   //     cart: (map[CART] as List<CartProductModel>)
//   //         .map((e) => CartProductModel.fromMap(e))
//   //         .toList(),
//   //   );
//   // }
//   PaymentsModel.fromMap(Map<String, dynamic> data) {
//     id = data[ID];
//     createdAt = data[CREATED_AT];
//     amount = data[AMOUNT];
//     status = data[STATUS];
//     cart = (data[CART] as List<dynamic>).cast<CartProductModel>();

//     clientId = data[CLIENT_ID];
//     clientName = data[CLIENT_NAME];
//   }

//   // factory PaymentsModel.fromJson(Map<String, dynamic> json) {
//   //   return PaymentsModel(
//   //     id: json[ID],
//   //     amount: json[AMOUNT],
//   //     status: json[STATUS],
//   //     createdAt: json[CREATED_AT],
//   //     clientId: json[CLIENT_ID],
//   //     clientName: json[CLIENT_NAME],
//   //     cart: (json[CART] as List<dynamic>)
//   //         .map((e) => CartProductModel.fromJson(e))
//   //         .toList(),
//   //   );
//   // }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data[ID] = this.id;
//     data[CLIENT_NAME] = this.clientName;
//     data[AMOUNT] = this.amount;
//     data[STATUS] = this.status;
//     data[CREATED_AT] = this.createdAt;
//     data[CLIENT_ID] = this.clientId;
//     // data[CART] = this.cart?.map((e) => e.toJson()).toList();
//     return data;
//   }

//   //
//   // List<Map<String, dynamic>>? cartItemsToJson() =>
//   //     cart?.map((item) => item.toJson()).toList();
//   // check this
// }
