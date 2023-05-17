import 'package:el_marsa/core/view_model/auth_view_model.dart';
import 'package:el_marsa/core/view_model/cart_view_model.dart';
import 'package:el_marsa/view/auth/login_screen.dart';
import 'package:el_marsa/view/cart_view.dart';
import 'package:el_marsa/view/home/categorie_view.dart';
import 'package:el_marsa/view/home/home_screen.dart';
import 'package:el_marsa/view/home/profile_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

import '../constance.dart';
import '../core/view_model/control_view_model.dart';
import '../helper/dimensions.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/custom_text.dart';
import '../widgets/icon_button_counter.dart';

class ControllView extends GetWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user == null)
          ? loginScreen()
          : GetBuilder<ControlViewModel>(
              init: ControlViewModel(),
              builder: (controller) => SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    toolbarHeight: 80.0,
                    backgroundColor: Colors.white,
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomSearchBar(),
                          SizedBox(
                            width: Dimensions.screenWidth / 100,
                          ),
                          GetBuilder<CartViewModel>(
                            init: CartViewModel(),
                            builder: (controller) {
                              return IconButtonCounter(
                                press: () {
                                  Get.to(CartView());
                                },
                                icon: Icons.shopping_cart_outlined,
                                numOfItem: controller.cartProductModel.length,
                              );
                            },
                          ),
                          IconButtonCounter(
                            icon: Icons.message,
                            press: () async {
                              dynamic conversationObject = {
                                'appId':
                                    '28aa7e0b6a4b43dcd55dfd05e741ebefd', // The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
                              };

                              KommunicateFlutterPlugin.buildConversation(
                                      conversationObject)
                                  .then((clientConversationId) {
                                print("Conversation builder success : " +
                                    clientConversationId.toString());
                              }).catchError((error) {
                                print("Conversation builder error : " +
                                    error.toString());
                              });
                            },
                            numOfItem: 0,
                          ),
                        ]),
                  ),
                  body: controller.currentScreen,
                  bottomNavigationBar: bottomNavigationBar(),
                ),
              ),
            );
    });
  }

  Widget bottomNavigationBar() {
    return GetBuilder<ControlViewModel>(
      init: Get.put(ControlViewModel()),
      builder: (controller) => BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              activeIcon: CustomeText(
                text: "Explore",
                color: green,
                alignment: Alignment.center,
              ),
              label: "",
              icon: Icon(Icons.home_rounded)),
          BottomNavigationBarItem(
              activeIcon: CustomeText(
                text: "Category",
                color: green,
                alignment: Alignment.center,
              ),
              label: "",
              icon: Icon(Icons.library_books_rounded)),

          BottomNavigationBarItem(
            activeIcon: CustomeText(
              text: "Acount",
              color: green,
              alignment: Alignment.center,
            ),
            label: "",
            icon: Icon(
              Icons.account_circle_outlined,
            ),
          ),
          //  BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home_rounded)),
        ],
        currentIndex: controller.navigatoreValue,
        onTap: (index) {
          controller.changeSelectedValue(index);
        },
        elevation: 0,
        // selectedItemColor: primaryColor,
        backgroundColor: Color.fromARGB(255, 243, 241, 241),
      ),
    );
  }
}
