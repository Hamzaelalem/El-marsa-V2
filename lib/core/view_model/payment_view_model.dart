import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_marsa/core/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:uuid/uuid.dart';

import '../../helper/local_storage_data.dart';
import '../../model/payment_model.dart';
import '../../view/payments/payments_view.dart';
import 'cart_view_model.dart';

class PaymentViewModel extends GetxController {
  static CartViewModel instance = Get.find();
  static ProfileViewModel instanc = Get.find();
  late CartViewModel cartViewModel;
  late ProfileViewModel profileViewModel;
  //late LocalStorgeData localStorgeData;
  Map<String, dynamic>? paymentIntent;

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  PaymentViewModel() {
    cartViewModel = instance;
    profileViewModel = instanc;
    
    // localStorgeData=localStorgeData;
  }

  String collection = 'orders';

  List<PaymentsModel> payments = [];
  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent(
          '${cartViewModel.total.toStringAsFixed(0)}', 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Ikay'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        await _addToCollection();
        //cartViewModel.cartProductModel = [];

        showDialog(
            context: Get.context!,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  _addToCollection() {
    String id = Uuid().v1();
    FirebaseFirestore.instance.collection(collection).doc(id).set({
      "id": id,
      "clientId": profileViewModel.userModel?.userId,
      "clientName": profileViewModel.userModel?.userName,
       "cart":

          cartViewModel.cartProductModel.map((item) => item.toJson()).toList(),
      "amount": cartViewModel.total.toStringAsFixed(1),
      "status": "untreated",
      "createdAt": DateTime.now().microsecondsSinceEpoch,
    });
  }

  // check for problem
  getPaymentHistory() async {
    //showLoading();
    _loading.value = false;

    payments.clear();
    await FirebaseFirestore.instance
        .collection(collection)
        .where(
          //localStorgeData.usermodel.userId
          "clientId",
          isEqualTo: profileViewModel.userModel?.userId,
        )
        .get()
        .then((snapshot) async {
      print('getPayment');
      print("length ${payments.length}");

      snapshot.docs.forEach((doc) {
        PaymentsModel payment = PaymentsModel.fromMap(doc.data());
        print('add payment');
        payments.add(payment);
        print(
          profileViewModel.userModel?.userId,
        );
      });
      print("length ${payments.length}");
      _loading.value = false;
      //logger.i("length ${payments.length}");
      //dismissLoadingWidget();
      Get.to(() => PaymentsScreen());
    });
  }
}
