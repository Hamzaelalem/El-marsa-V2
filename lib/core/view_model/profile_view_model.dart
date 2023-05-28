import 'package:cloud_firestore/cloud_firestore.dart';
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
  void onInit() async{
    super.onInit();
    //paymentViewModel = Get.find();
    // Get.delete<ProfileViewModel>();
    //Get.put(ProfileViewModel());
   await refrshUserData();

    getCurrentUser();

    // print("userModel p");
    // print(userModel);
  }

  //late PaymentViewModel paymentViewModel;
  final LocalStorgeData localStorgeData = Get.find();

  //final PaymentViewModel paymentViewModel = Get.find();

  UserModel? get userModel => _userModel;
  UserModel? _userModel;
  late String userId;

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

// refrshUserData()async{
//   await FirebaseFirestore.instance
//         .collection('users')
//         .where(
//           //localStorgeData.usermodel.userId
//           "userId",
//           isEqualTo: "js",
//         )
//         .get()
//         .then((snapshot) async {

//       snapshot.docs.forEach((doc) {
//         //print(jsonEncode(doc.data()));
//         UserModel userModel=UserModel.fromJason(doc.data());

//         print('add payment');
//        //  setUser(userModel);
//       });
// }
// String? userId=_userModel!.userId;
  Future refrshUserData() async {
    _loading.value = true;
    //userId = userModel!.userId!;
    await FirebaseFirestore.instance
        .collection('users')
        .where(
            //localStorgeData.usermodel.userId
            "userId",
            isEqualTo: "2I787Co1E2N0uxuLUXySNsEDCwN2")
        .get()
        .then((snapshot) async {
      snapshot.docs.forEach((doc) {
        //print(jsonEncode(doc.data()));
        UserModel userModel = UserModel.fromJason(doc.data());
         localStorgeData.deletUser();
        setUser(userModel);

        print('refresh user data  ' '${userModel.userEmail}');
         setUser(userModel);
         getCurrentUser();
      });
      _loading.value = false;
    });
  }

  void setUser(UserModel userModel) async {
    await localStorgeData.setUser(userModel);
  }

  void getCurrentUser() async {
    _loading.value = true;
    final user = await localStorgeData.getUser;

    _userModel = user!;
    update();
    print("userId");
    print(userModel!.userId);
    _loading.value = false;
  }

  final Uri _url = Uri.parse('https://dashboard.kommunicate.io/conversations');
  Future<void> AdminChatPanel() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
