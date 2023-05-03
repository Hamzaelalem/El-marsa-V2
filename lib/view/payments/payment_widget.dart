import 'package:el_marsa/core/view_model/payment_view_model.dart';
import 'package:el_marsa/model/payment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:timeago/timeago.dart' as timeago;

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
                text: "3",
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
          Column(
              children: paymentsModel.cart!
                  .map((item) => ListTile(
                        title: CustomeText(text: item.name),
                      ))
                  .toList()),
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
          Divider(),
          ListTile(
            title: CustomeText(
              text: _returnDate(),
              color: Colors.grey,
            ),
            trailing: SizedBox(
              width: 100,
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
