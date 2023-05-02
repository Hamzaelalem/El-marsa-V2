import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_marsa/core/services/home_service.dart';
import 'package:el_marsa/model/categorie_model.dart';
import 'package:el_marsa/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../helper/local_storage_data.dart';

final LocalStorgeData localStorgeData = Get.find();

class HomeViewModel extends GetxController {
  List<CategorieModel> get categorieList => _categorieList;
  List<CategorieModel> _categorieList = [];

  List<ProductModel> get productsList => _productsList;
  List<ProductModel> _productsList = [];

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  HomeViewModel() {
    getCategorie();
    getProducts();
  }

  getCategorie() async {
    _loading.value = true;
    HomeService().getCategorie().then((value) {
      //print(value.docs[0].data());
      for (int i = 0; i < value.length; i++) {
        _categorieList.add(
            CategorieModel.fromJason(value[i].data() as Map<dynamic, dynamic>));

        _loading.value = false;
      }

      update();
    });
  }

  getProducts() async {
    _loading.value = true;
    HomeService().getProducts().then((value) {
      for (var i = 0; i < value.length; i++) {
        _productsList.add(
            ProductModel.fromJson(value[i].data() as Map<dynamic, dynamic>));

        _loading.value = false;
        print(value.length);
      }
    });
  }

  // Your existing code

  String PercentageDiscount(String? oldPrice, String? price) {
    if (oldPrice == null || price == null) {
      return '0%'; // or any other default value
    }

    double oldPriceValue = double.tryParse(oldPrice) ?? 0.0;
    double priceValue = double.tryParse(price) ?? 0.0;

    if (oldPriceValue == 0.0 || priceValue == 0.0) {
      return '0%'; // or any other default value
    }

    double percentageDiscountValue =
        ((oldPriceValue - priceValue) / oldPriceValue) * 100;
    String percentageDiscountString =
        percentageDiscountValue.toStringAsFixed(1);

    return '-$percentageDiscountString%';
  }

  Future<void> signOut() async {
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
    localStorgeData.deletUser();
  }
}
