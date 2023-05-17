import 'package:el_marsa/core/view_model/payment_view_model.dart';
import 'package:el_marsa/helper/local_storage_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/user_model.dart';
import '../../view/auth/login_screen.dart';

class ProfileViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  @override
  void onInit() {
    super.onInit();
    //paymentViewModel = Get.find();
    

    getCurrentUser();
    // print("userModel p");
    // print(userModel);
  }

  //late PaymentViewModel paymentViewModel;
  final LocalStorgeData localStorgeData = Get.find();

  //final PaymentViewModel paymentViewModel = Get.find();

  UserModel? get userModel => _userModel;
  UserModel? _userModel;

  Future<void> signOut() async {
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
   // paymentViewModel.payments = [];
    localStorgeData.deletUser();
    Get.offAll(loginScreen());
  }

  // void getCurrentUser() async {
  //   await localStorgeData.getUser.then((value) {
  //     _userModel = value!;
  //   });
  //   update();
  // }

//   void getCurrentUser() async {
//   await localStorgeData.getUser.then((value) {
//     if (value != null) {
//       _userModel = value;
//     } else {
//       _userModel = UserModel();
//     }
//   });
//   update();
// }

  void getCurrentUser() async {
    _loading.value = true;
    final user = await localStorgeData.getUser;

    _userModel = user!;
    update();
    // print("userId");
    // print(_userModel!.userId);
    _loading.value = false;
  }

   final Uri _url = Uri.parse('https://dashboard.kommunicate.io/conversations');
  Future<void> AdminChatPanel() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
}
