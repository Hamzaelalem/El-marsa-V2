import 'package:el_marsa/constance.dart';
import 'package:el_marsa/core/view_model/cart_view_model.dart';
import 'package:el_marsa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<CartViewModel>(
                init: Get.put(CartViewModel()),
                builder: (controler) => ListView.separated(
                  itemBuilder: (context, index) {
                    //double price = double.tryParse(controller.productsList[index].price ?? "") ?? 0.0;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 140,
                        child: Row(
                          children: [
                            Container(
                                width: 100,
                                child: controler.cartProductModel[index]
                                                .image ==
                                            null ||
                                        controler.cartProductModel[index]
                                                .image ==
                                            ""
                                    ? Image.asset('assets/images/iphone14.png')
                                    : Image.network(controler
                                        .cartProductModel[index].image!)),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomeText(
                                    text:
                                        "${controler.cartProductModel[index].name}",
                                    fontSize: 22,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomeText(
                                    text:
                                        '${controler.cartProductModel[index].price}',
                                    color: primaryColor,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: 140,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[200],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              controler.increaseQty(index);
                                            },
                                            child: Icon(Icons.add)),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        CustomeText(
                                          alignment: Alignment.center,
                                          text: controler
                                              .cartProductModel[index].qty
                                              .toString(),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              controler.decreaseQty(index);
                                            },
                                            child: Icon(Icons.remove)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: controler.cartProductModel.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GetBuilder<CartViewModel>(
              //  Get.put(CartViewModel())
              init: Get.put(CartViewModel()),
              builder: (controller) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CustomeText(
                              text: "TOTAL",
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            Row(
                              children: [
                                CustomeText(
                                  text: "${controller.total}",
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Checkout"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,

                          // padding: padding,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
            //
          ],
        ),
      )),
    );
  }
}
