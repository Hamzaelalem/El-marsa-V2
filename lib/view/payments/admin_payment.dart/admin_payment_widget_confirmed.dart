import 'package:el_marsa/core/view_model/payment_view_model.dart';
import 'package:el_marsa/model/payment_model.dart';
import 'package:el_marsa/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../widgets/custom_text.dart';

class AdminPaymentWidgetConfirmed extends StatelessWidget {
  //static PaymentViewModel instance = Get.find();
  final PaymentsModel paymentsModel;

  const AdminPaymentWidgetConfirmed({
    Key? key,
    required this.paymentsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentViewModel>(
        init: PaymentViewModel(),
        initState: (_) {},
        builder: (Controller) => Controller.loading.value
            ? Center(child: CircularProgressIndicator())
            : Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.5), blurRadius: 15)
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
                                                  Text('Items Details :',
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                      )),
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
                        GetBuilder<PaymentViewModel>(
                          init: PaymentViewModel(),
                          //initState: (_) {},
                          builder: (controller) {
                            return ElevatedButton(
                              onPressed: () {
                                controller.AdminSentOrder(paymentsModel.id!);
                                // controller.ConfirmOrder
                              },
                              child: Text(' Sent'),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 2, 74, 90)),
                              ),
                            );
                          },
                        ),
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
              ));
  }

  String _returnDate() {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(paymentsModel.createdAt!);
    return timeago.format(date, locale: 'fr');
  }
}
