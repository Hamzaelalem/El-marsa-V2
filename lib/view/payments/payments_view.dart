import 'package:el_marsa/core/view_model/payment_view_model.dart';
import 'package:el_marsa/view/payments/payment_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class PaymentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentViewModel>(
      init: PaymentViewModel(),
      builder: (controller) => controller.loading.value
          ? Center(child: CircularProgressIndicator())
    
   : Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.grey.withOpacity(.1),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Payment History",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GetBuilder<PaymentViewModel>(
        init: PaymentViewModel(),
        
        builder: (controller) {
          return ListView(
            children: [
              Column(children: controller.payments.map((payment) => PaymentWidget(paymentsModel: payment,)).toList() 

                  // payments.map((payment) => PaymentWidget(paymentsModel: payment,)).toList()
                  //     PaymentsModel(
                  //       amount: "12",
                  //       status: "completed",
                  //       createdAt: 1682729875076 )
                  //   ].map((payment) =>PaymentWidget()).toList()
                  )
            ],
          );
        },
      ),
    )
    );
  }
}
//    paymentsController.payments.map((payment) => PaymentWidget(paymentsModel: payment,)).toList()
            