import 'dart:convert';

import 'package:el_marsa/main.dart';
import 'package:el_marsa/model/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constance.dart';

class LocalStorgeData extends GetxController {
  Future<UserModel?> get getUser async {
    try {
      UserModel userModel = await _getUserData();
      if (userModel == null) {
        return null;
      }
      return userModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  _getUserData() async {
    var value = prefs1.getString(CASHED_USER_DATA);
    return UserModel.fromJason(json.decode(value!));
  }

  setUser(UserModel userModel) async {
    await prefs1.setString(CASHED_USER_DATA, json.encode(userModel.toJason()));
    print("SET USER LOCAL STORAGE TO JASON");
    print(userModel.toJason());
  }

  void deletUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs1.clear();
  }
}
