import 'package:el_marsa/core/view_model/payment_view_model.dart';
import 'package:el_marsa/model/payment_model.dart';
import 'package:el_marsa/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../model/cart_product_model.dart';
import '../../model/payment_model.dart';
import '../../model/payment_model.dart';
import '../../widgets/custom_text.dart';

class PaymentWidget extends StatelessWidget {
  //static PaymentViewModel instance = Get.find();
  final PaymentsModel paymentsModel;

  const PaymentWidget({
    Key? key,
    required this.paymentsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 15)
          ]),
      child: Wrap(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomeText(
                  text: "ITEMS:",
                  color: Colors.grey,
                ),
              ),
              // paymentsModel.cart.length.toString()
              CustomeText(
                text: '${paymentsModel.cart!.length}',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomeText(
                  text: " \$ ${paymentsModel.amount}",
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: 5,
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              TextButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                         Text('Items Details :',style: TextStyle(color: Colors.green ,)),
                                        Divider(
                                                height: 4,
                                                thickness: 2,
                                              ),
                                        SizedBox(height: 15),
                                        for (final cartItem
                                            in paymentsModel.cart!)
                                          Column(
                                            children: [
                                              Text('Product  '),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Center(
                                                child: Text(' name : ' +
                                                    '${cartItem.name}'),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Center(
                                                child: Text(' price : ' +
                                                    '${cartItem.price}'),
                                              ),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Divider(
                                                height: 4,
                                                thickness: 2,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ));
                  },
                  child: Text("  Item Details")),
              Spacer(),
            
              SizedBox(
                width: 10,
              )
            ],
          ),
          Divider(),
          ListTile(
            title: CustomeText(
              text: _returnDate(),
              color: Colors.grey,
            ),
            trailing: SizedBox(
              width: 80,
              child: CustomeText(
                text: paymentsModel.status,
                color: Colors.green,
              ),
            ),
          )
        ],
      ),
    );
  }

  String _returnDate() {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(paymentsModel.createdAt!);
    return timeago.format(date, locale: 'fr');
  }
}

// Column(
//   children: paymentsModel.cart!
//       .map((item) =>
//           PaymentsModel.fromMap(item as Map<String, dynamic>)
//       .map((item) => ListTile(
//             title: CustomeText(
//               text: item.name!,
//             ),
//             trailing: CustomeText(
//               text: "\$ ${item.price}",
//             ),
//           ))
//       .toList(),
// ),

//          Column(
//   children: paymentsModel.cart!
//     .map((item) => CartProductModel.fromJson(item as Map<String, dynamic>))
//     .map((item) => ListTile(
//       title: CustomeText(text: item.name),
//     ))
//     .toList() ,
// ),

// Column(
//     children: paymentsModel.cart!
//         .map((item) => ListTile(
//               title: CustomeText(
//                 text: item.name,
//               ),
//               trailing: CustomeText(
//                 text: "\$ ${item.price}",
//               ),
//             ))
//         .toList()),




 // Expanded(
          //   child: ListView.separated(itemBuilder: (context, index) {
          //     return
          // Text(paymentsModel.cart![0].price.toString()),
          //     ListTile(
          //                 title: CustomeText(
          //                   text: 'qwerty',
          //                 ),
          //                 trailing: CustomeText(
          //                   text: "\$ 12",
          //                 ),
          //               ),
          // //               ;
          //   }, separatorBuilder: (context, index) {
          //     return SizedBox(height: 3,);
          //   }, itemCount: paymentsModel.cart!.length),
          // ),
          // Column(
          //     children: paymentsModel.cart!
          //         . PaymentsModel.fromMap((item ) =>
          //         .toList()),


           // Expanded(
                              //   child: ListView.builder(
                              //       itemBuilder: (context, index) {
                              //         Column(children: [
                              //           Text(
                              //               ' ${paymentsModel.cart![index].name}'),
                              //           Text(
                              //               ' ${paymentsModel.cart![index].name}'),
                              //         ]);
                              //       },
                              //       itemCount: paymentsModel.cart!.length),
                              // )



                              //          TextButton(
//   onPressed: () {
//     showDialog(
//             context: Get.context!,
//             builder: (_) => AlertDialog(
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         Icons.check_circle,
//                         color: Colors.green,
//                         size: 100.0,
//                       ),
//                       SizedBox(height: 10.0),
//                       Text(' ${paymentsModel.cart![0].name}'),
//                     ],
//                   ),
//                 ));
//   },
//   child: Text("Item Details"),
// ),