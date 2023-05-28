import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_marsa/core/view_model/control_view_model.dart';
import 'package:el_marsa/core/view_model/home_view_model.dart';
import 'package:el_marsa/helper/dimensions.dart';
import 'package:el_marsa/view/auth/login_screen.dart';
import 'package:el_marsa/view/home/details_view.dart';
import 'package:el_marsa/widgets/custom_search_bar.dart';
import 'package:el_marsa/widgets/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

import '../../constance.dart';
import '../../widgets/icon_button_counter.dart';
import '../../widgets/view_all_button.dart';

class HomeScreen extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: Get.put(HomeViewModel()),
      builder: (controller) => controller.loading.value
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              body: Padding(
                padding: EdgeInsets.only(
                    top: Dimensions.screenHeight / 150,
                    left: Dimensions.screenWidth / 40,
                    right: Dimensions.screenWidth / 40,
                    bottom: Dimensions.screenHeight / 150),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomeText(
                            text: "Categories",
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font20,
                          ),
                          Spacer(),
                          ViewAllButton(
                            onPress: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight / 120,
                      ),

                      //
                      _ListViewCategory(),

                      Row(
                        children: [
                          CustomeText(
                            text: "Best Selling",
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font20,
                          ),
                          Spacer(),
                          ViewAllButton(
                            onPress: () {
                              print(Dimensions.screenHeight / 3);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight / 150,
                      ),
                      _ListViewProduct(),

                      SizedBox(
                        height: Dimensions.containerHeigth220 / 10,
                      ),
                      Row(
                        children: [
                          CustomeText(
                            text: "New arrival",
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font20,
                          ),
                          Spacer(),
                          ViewAllButton(
                            onPress: () {
                              print(Dimensions.screenHeight / 3);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight / 150,
                      ),
                      _ListViewProduct1(),
                      Center(
                        child: FloatingActionButton(
                          child: Text("homePage"),
                          onPressed: () {
                            controller.signOut();
                            Get.offAll(loginScreen());
                          },
                        ),
                      ),
                      // signed out button
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _ListViewCategory() {
    // fix height
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        height: Dimensions.containerHeigth120,
        child: ListView.builder(
          itemCount: controller.categorieList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 240, 241, 241),
                      ),
                      child: Center(
                          child: Container(
                              height: 60,
                              width: 60,
                              child: controller.categorieList[index].image ==
                                          null ||
                                      controller.categorieList[index].image ==
                                          ""
                                  ? Image.asset(
                                      // Replace it with a static categorie image like a logo
                                      'assets/images/iphone14.png',
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      controller.categorieList[index].image!,
                                      fit: BoxFit.fill,
                                    ))),
                    ),
                    SizedBox(height: Dimensions.heigth10),
                    Center(
                      child: Container(
                        width: 60,
                        // color: Colors.red,
                        child: CustomeText(
                          text: controller.categorieList[index].name,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: Dimensions.width15,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _ListViewProduct() {
    // Call the method to calculate the percentage discount

    // fix height
    return GetBuilder<HomeViewModel>(
      builder: (controler) => Container(
          height: 218,

          // color: Colors.red,
          child: ListView.separated(
              itemCount: controler.productsList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String? oldPrice = controler.productsList[index].oldPrice;
                String? discountedPrice = controler.productsList[index].price;
                String? percentageDiscount =
                    controler.PercentageDiscount(oldPrice, discountedPrice);
                String? percentageDiscountString =
                    percentageDiscount.toString(); // Convert double to String
                return Container(
                  width: Dimensions.screenWidth * .4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 240, 241, 241),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => DetailsView(
                                index1: index,
                                Model: controler.productsList[index],
                              ));

                          //print(controler.productsList[index].image);
                        },
                        child: Container(
                            height: 140,
                            width: Dimensions.screenWidth * .4,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                controler.productsList[index].image == "" ||
                                        controler.productsList[index].image ==
                                            null
                                    ? Image.asset(
                                        // Replace it with a static categorie image like a logo
                                        'assets/images/iphone14.png',
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        controler.productsList[index].image!,
                                        fit: BoxFit.fill,
                                      ),
                                Positioned(
                                  //top: 1,
                                  right: 1,
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 254, 255, 255),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // top: 8,
                                  left: 0,
                                  child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 229, 226, 36),
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: CustomeText(
                                        text: "${percentageDiscountString}",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, bottom: 2),
                        child: Column(
                          children: [
                            CustomeText(
                              text: "${controler.productsList[index].name}",
                              alignment: Alignment.bottomLeft,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            CustomeText(
                              text:
                                  "${controler.productsList[index].description}",
                              color: Colors.grey,
                              alignment: Alignment.bottomLeft,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                CustomeText(
                                  text: "TND",
                                  color: primaryColor,
                                  fontSize: 10,
                                  alignment: Alignment.bottomLeft,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                CustomeText(
                                  text:
                                      "${controler.productsList[index].price}",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ],
                        ),
                        
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                    width: Dimensions.screenWidth * .04,
                  ))),
    );
  }
}

Widget _ListViewProduct1() {
  // Call the method to calculate the percentage discount

  // fix height
  return GetBuilder<HomeViewModel>(
    builder: (controler) => Container(
        height: 218,

        // color: Colors.red,
        child: ListView.separated(
            itemCount: controler.productsList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              String? oldPrice = controler.productsList[index].oldPrice;
              String? discountedPrice = controler.productsList[index].price;
              String? percentageDiscount =
                  controler.PercentageDiscount(oldPrice, discountedPrice);
              String? percentageDiscountString =
                  percentageDiscount.toString(); // Convert double to String
              return Container(
                width: Dimensions.screenWidth * .4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 240, 241, 241),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => DetailsView(
                              index1: index,
                              Model: controler.productsList[index],
                            ));

                        //print(controler.productsList[index].image);
                      },
                      child: Container(
                          height: 140,
                          width: Dimensions.screenWidth * .4,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              controler.productsList[index].image == "" ||
                                      controler.productsList[index].image ==
                                          null
                                  ? Image.asset(
                                      // Replace it with a static categorie image like a logo
                                      'assets/images/iphone14.png',
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      controler.productsList[index].image!,
                                      fit: BoxFit.fill,
                                    ),
                              Positioned(
                                //top: 1,
                                right: 1,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 254, 255, 255),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                // top: 8,
                                left: 0,
                                child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 229, 226, 36),
                                        borderRadius: BorderRadius.circular(2)),
                                    child: CustomeText(
                                      text: "${percentageDiscountString}",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, bottom: 2),
                      child: Column(
                        children: [
                          CustomeText(
                            text: "${controler.productsList[index].name}",
                            alignment: Alignment.bottomLeft,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          CustomeText(
                            text:
                                "${controler.productsList[index].description}",
                            color: Colors.grey,
                            alignment: Alignment.bottomLeft,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              CustomeText(
                                text: "TND",
                                color: primaryColor,
                                fontSize: 10,
                                alignment: Alignment.bottomLeft,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              CustomeText(
                                text: "${controler.productsList[index].price}",
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: Dimensions.screenWidth * .04,
                ))),
  );
}
