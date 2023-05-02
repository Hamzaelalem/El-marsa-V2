import 'package:el_marsa/helper/local_storage_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/user_model.dart';

class ProfileViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  @override
  void onInit() {
    super.onInit();

    getCurrentUser();
    print("userModel p");
    print(userModel);
  }

  final LocalStorgeData localStorgeData = Get.find();

  UserModel? get userModel => _userModel;
  UserModel? _userModel;

  Future<void> signOut() async {
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
    //
    localStorgeData.deletUser();
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
}
