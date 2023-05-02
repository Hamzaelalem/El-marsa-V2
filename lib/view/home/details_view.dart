import 'package:el_marsa/constance.dart';
import 'package:el_marsa/core/view_model/cart_view_model.dart';
import 'package:el_marsa/model/cart_product_model.dart';
import 'package:el_marsa/model/categorie_model.dart';
import 'package:el_marsa/model/product_model.dart';
import 'package:el_marsa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../widgets/custom_formButton.dart';

class DetailsView extends StatelessWidget {
  final ProductModel? Model;
  const DetailsView({this.Model});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //Padding(
              // padding: const EdgeInsets.only(top: 35),
              // child: Row(
              //   children: [
              //     IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
              //     Spacer(),
              //     Container(
              //       padding: EdgeInsets.all(2),
              //       decoration: BoxDecoration(
              //           color: Color.fromARGB(255, 254, 255, 255),
              //           borderRadius: BorderRadius.circular(50)),
              //       child: InkWell(
              //         onTap: () {},
              //         child: Icon(
              //           Icons.favorite_border,
              //           color: Colors.grey,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // ),
              Container(
                // width: MediaQuery.of(context).size.width,
                height: 300,
                child: Model?.image == "" || Model?.image == null
                    ? Image.asset(
                        // Replace it with a static categorie image like a logo
                        'assets/images/iphone14.png',
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        Model!.image!,
                        fit: BoxFit.fill,
                      ),
              ),
              SizedBox(
                height: 19,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomeText(
                      text: Model!.name! + "  " + Model!.description!,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    CustomeText(
                      text: "Details",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    CustomeText(
                      text: Model!.description!,
                      overflow: TextOverflow.visible,
                      height: 1.5,
                    ),
                  ],
                ),
              )),

              // Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder<CartViewModel>(
                  init: Get.put(CartViewModel()),

                  // init: CartViewModel(),
                  // initState: (_) {},
                  builder: (controler) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              CustomeText(
                                text: "PRICE",
                                // alignment: Alignment.center,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                              Row(
                                children: [
                                  CustomeText(
                                    text: Model!.price!,
                                    fontWeight: FontWeight.bold,
                                    //fontSize: 25,
                                    color: primaryColor,
                                  ),
                                  // CustomeText("OMR"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0)),
                          child: ElevatedButton(
                            onPressed: () {
                              controler.addProduct(CartProductModel(
                                name: Model!.name,
                                price: Model?.price,
                                image: Model?.image,
                                productId: Model?.productId,
                                qty: 1,
                              ));
                            },
                            child: Text("add"),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
