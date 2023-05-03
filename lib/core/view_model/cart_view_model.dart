import 'package:el_marsa/core/services/Database/cart_db_heper.dart';
import 'package:el_marsa/model/cart_product_model.dart';
import 'package:el_marsa/view/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class CartViewModel extends GetxController {
  ValueNotifier<bool> get laoding => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<CartProductModel> _cartProductModel = [];

  List<CartProductModel> get cartProductModel => _cartProductModel;
  var dbHelper = CartDbHelper.db;
  CartViewModel() {
    getAllProduct();
  }

  getAllProduct() async {
    _loading.value = true;

    _cartProductModel = (await dbHelper.getAllProduct())!;
    // print("getAllProduct");
    // print(_cartProductModel.length);
    _loading.value = false;
    gettotal();
    update();
  }

  double get total => _total;
  double _total = 0.0;
  gettotal() {
    for (int i = 0; i < _cartProductModel.length; i++) {
      _total +=
          double.parse(_cartProductModel[i].price!) * _cartProductModel[i].qty!;

      // print("product qty");
      // print(_cartProductModel[i].qty!);
    }
    // print("_total");
    // print(_total);
    // print("total");
    // print(total);

    update();
  }

  addProduct(CartProductModel cartProductModel) async {
    for (int i = 0; i < _cartProductModel.length; i++) {
      if (cartProductModel.productId == _cartProductModel[i].productId) {
        return;
      }
    }

    await dbHelper.insert(cartProductModel);
    _cartProductModel.add(cartProductModel);
    _total += double.parse(cartProductModel.price!) * cartProductModel.qty!;
    update();
  }

  increaseQty(int index) async {
    _cartProductModel[index].qty = (_cartProductModel[index].qty ?? 0) + 1;
    _total += double.parse(_cartProductModel[index].price!);
    await dbHelper.updadteProduct(_cartProductModel[index]);
    update();
  }

  decreaseQty(int index) async {
    if (_cartProductModel[index].qty! > 1) {
      _cartProductModel[index].qty = (_cartProductModel[index].qty ?? 0) - 1;
      _total -= double.parse(_cartProductModel[index].price!);
      await dbHelper.updadteProduct(_cartProductModel[index]);
      
      update();
    }
  }
}
