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

import '../../core/view_model/home_view_model.dart';
import '../../widgets/custom_formButton.dart';
import 'ar_view.dart';



///////////////////////////////////////////
class DetailsView extends StatelessWidget {
  final ProductModel? Model;
  final int index1;
  const DetailsView({this.Model, required this.index1});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
        builder: (controler) => SafeArea(
              child: Scaffold(
                //get controller
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
                        // width: 300,
                        // height: 400,
                        child: Stack(children: [
                          Container(
                            //width: 300,

                            // width: MediaQuery.of(context).size.width,
                            //height: 300,
                            child: Model?.image == "" || Model?.image == null
                                ? Container(
                                    height: 300,
                                    child: Image.asset(
                                      // Replace it with a static categorie image like a logo
                                      'assets/images/iphone14.png',
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : Container(
                                    height: 300,
                                    child: Image.network(
                                      Model!.image!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                          ),
                          Positioned(
                            bottom: 1,
                            left: 0,
                            right: 0,
                            child: Container(
                                width: 70,
                                height: 40,
                                child: Model!.ar! != ""
                                    ? ElevatedButton(
                                        onPressed: () {
                                          Get.to(() => AR_View(
                                                Model: controler
                                                    .productsList[index1],
                                              ));
                                          print(index1);
                                          // Get.to(AR_View());
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.black54),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            "view in ar",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox()),
                          ),
                        ]),
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
                                      Get.snackbar(
                                        "succes",
                                        "add to cart succesfully !",
                                      );
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
            ));
  }
}



/// ar view 
// Container(
//                 // width: 300,
//                 // height: 400,
//                 child: Stack(children: [
//                   Container(
//                     //width: 300,

//                     // width: MediaQuery.of(context).size.width,
//                     //height: 300,
//                     child: Model?.image == "" || Model?.image == null
//                         ? Container(
//                             height: 300,
//                             child: Image.asset(
//                               // Replace it with a static categorie image like a logo
//                               'assets/images/iphone14.png',
//                               fit: BoxFit.fill,
//                             ),
//                           )
//                         : Container(
//                             height: 300,
//                             child: Image.network(
//                               Model!.image!,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                   ),
//                   Positioned(
//                     bottom: 1,
//                     left: 0,
//                     right: 0,
//                     child: Container(
//                       width: 70,
//                       height: 40,
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all<Color>(Colors.black54),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ),
//                         ),
//                         child: Container(
//                           padding:
//                               EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                           child: Text(
//                             "view in ar",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ]),
//               ),



// delate 


// class DetailsView extends StatelessWidget {
//   final ProductModel? Model;
//   const DetailsView({this.Model});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               //Padding(
//               // padding: const EdgeInsets.only(top: 35),
//               // child: Row(
//               //   children: [
//               //     IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
//               //     Spacer(),
//               //     Container(
//               //       padding: EdgeInsets.all(2),
//               //       decoration: BoxDecoration(
//               //           color: Color.fromARGB(255, 254, 255, 255),
//               //           borderRadius: BorderRadius.circular(50)),
//               //       child: InkWell(
//               //         onTap: () {},
//               //         child: Icon(
//               //           Icons.favorite_border,
//               //           color: Colors.grey,
//               //         ),
//               //       ),
//               //     ),
//               //   ],
//               // ),
//               // ),
//               Stack(
//                 children: [
//                   Container(
//                     // width: MediaQuery.of(context).size.width,
//                     //height: 300,
//                     child: Model?.image == "" || Model?.image == null
//                         ? Image.asset(
//                             // Replace it with a static categorie image like a logo
//                             'assets/images/iphone14.png',
//                             fit: BoxFit.fill,
//                           )
//                         : Image.network(
//                             Model!.image!,
//                             fit: BoxFit.fill,
//                           ),
//                   ),
//                   Positioned(
//                     bottom: 1,
//                     left: 0,
//                     right: 0,
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all<Color>(Colors.black54),
//                         shape:
//                             MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                         ),
//                       ),
//                       child: Container(
//                         padding:
//                             EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                         child: Text(
//                           "view in ar",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(
//                 height: 19,
//               ),
//               Expanded(
//                   child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     CustomeText(
//                       text: Model!.name! + "  " + Model!.description!,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 30,
//                     ),
//                     SizedBox(
//                       height: 35,
//                     ),
//                     CustomeText(
//                       text: "Details",
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                     ),
//                     SizedBox(
//                       height: 1,
//                     ),
//                     CustomeText(
//                       text: Model!.description!,
//                       overflow: TextOverflow.visible,
//                       height: 1.5,
//                     ),
//                   ],
//                 ),
//               )),

//               // Spacer(),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GetBuilder<CartViewModel>(
//                   init: Get.put(CartViewModel()),

//                   // init: CartViewModel(),
//                   // initState: (_) {},
//                   builder: (controler) {
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           child: Column(
//                             children: [
//                               CustomeText(
//                                 text: "PRICE",
//                                 // alignment: Alignment.center,
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               Row(
//                                 children: [
//                                   CustomeText(
//                                     text: Model!.price!,
//                                     fontWeight: FontWeight.bold,
//                                     //fontSize: 25,
//                                     color: primaryColor,
//                                   ),
//                                   // CustomeText("OMR"),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           height: 50,
//                           width: 200,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(0)),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               controler.addProduct(CartProductModel(
//                                 name: Model!.name,
//                                 price: Model?.price,
//                                 image: Model?.image,
//                                 productId: Model?.productId,
//                                 qty: 1,
//                               ));
//                               Get.snackbar("success", "produits ajoute");
//                             },
//                             child: Text("add"),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: primaryColor,

//                               // padding: padding,
//                             ),
//                           ),
//                         )
//                       ],
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }