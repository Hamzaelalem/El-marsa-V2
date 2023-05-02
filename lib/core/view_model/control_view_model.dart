import 'package:el_marsa/view/cart_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../view/home/categorie_view.dart';
import '../../view/home/home_screen.dart';
import '../../view/home/profile_view.dart';

class ControlViewModel extends GetxController {
  int _navigatoreValue = 0;

  get navigatoreValue => _navigatoreValue;

  Widget _currentScreen = HomeScreen();

  get currentScreen => _currentScreen;
  void changeSelectedValue(int SelectedValue) {
    _navigatoreValue = SelectedValue;
    switch (SelectedValue) {
      case 0:
        {
          _currentScreen = HomeScreen();
          break;
        }
      case 1:
        {
          _currentScreen = CartView();
          break;
        }
      case 2:
        {
          _currentScreen = ProfileView();
          break;
        }
    }
    update();
  }
}
