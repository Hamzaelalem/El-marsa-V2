import 'package:el_marsa/constance.dart';
import 'package:el_marsa/view/payments/admin_payment.dart/admin_payment_widget_confirmed.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../core/view_model/payment_view_model.dart';
import '../payments/admin_payment.dart/admin_payment_widget_untreated.dart';
import '../payments/payment_widget.dart';

import 'package:el_marsa/constance.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../core/view_model/payment_view_model.dart';
import '../payments/payment_widget.dart';

class MyTabPage extends StatefulWidget {
  @override
  _MyTabPageState createState() => _MyTabPageState();
}

class _MyTabPageState extends State<MyTabPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTab(String title) {
    return Center(
      child: GetBuilder<PaymentViewModel>(
        init: PaymentViewModel(),
        initState: (_) {},
        builder: (cnt) {
          return ElevatedButton(
            onPressed: () {
              cnt.paymentsAdminUntreated;
              cnt.paymentsAdminConfirmed;
              cnt.paymentsAdminSent;
              // Handle button press
              print('Button pressed in  tab');
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Button'),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Order Management'),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            //indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  ' Untreated',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'Confirmed',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'Sent',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                GetBuilder<PaymentViewModel>(
                  init: PaymentViewModel(),
                  builder: (controller) => controller.loading.value
                      ? Center(child: CircularProgressIndicator())
                      : ListView(
                          children: controller.paymentsAdminUntreated
                              .map((payment) => AdminPaymentWidgetUntreated(
                                    paymentsModel: payment,
                                  ))
                              .toList(),
                        ),
                ),
                GetBuilder<PaymentViewModel>(
                  init: PaymentViewModel(),
                  builder: (controller) => controller.loading.value
                      ? Center(child: CircularProgressIndicator())
                      : ListView(
                          children: controller.paymentsAdminConfirmed
                              .map((payment) => AdminPaymentWidgetConfirmed(
                                    paymentsModel: payment,
                                  ))
                              .toList(),
                        ),
                ),
                GetBuilder<PaymentViewModel>(
                  init: PaymentViewModel(),
                  builder: (controller) => controller.loading.value
                      ? Center(child: CircularProgressIndicator())
                      : ListView(
                          children: controller.paymentsAdminSent
                              .map((payment) => PaymentWidget(
                                    paymentsModel: payment,
                                  ))
                              .toList(),
                        ),
                ),
                // _buildTab('Confirmed'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}















///////////////////////
// class MyTabPage extends StatefulWidget {
//   @override
//   _MyTabPageState createState() => _MyTabPageState();
// }

// class _MyTabPageState extends State<MyTabPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Widget _buildTab(String title) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           // Handle button press
//           print('Button pressed in $title tab');
//         },
//         style: ElevatedButton.styleFrom(
          
//           padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//           textStyle: TextStyle(fontSize: 18),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         child: Text('Button'),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         title: Text('order management'),
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.white,
//           tabs: [
//             Tab(
            
  
//    child: GetBuilder<PaymentViewModel>(
//       init: PaymentViewModel(),
//       builder: (controller) => controller.loading.value
//           ? Center(child: CircularProgressIndicator())
    
//    : Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             icon: Icon(Icons.close),
//             onPressed: () {
//               Navigator.pop(context);
//             }),
//         backgroundColor: Colors.grey.withOpacity(.1),
//         iconTheme: IconThemeData(color: Colors.black),
//         centerTitle: true,
//         elevation: 0,
//         title: Text(
//           "Payment History",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: GetBuilder<PaymentViewModel>(
//         init: PaymentViewModel(),
        
//         builder: (controller) {
//           return ListView(
//             children: [
//               Column(children: controller.paymentsAdmin.map((payment) => PaymentWidget(paymentsModel: payment,)).toList() 

//                   // payments.map((payment) => PaymentWidget(paymentsModel: payment,)).toList()
//                   //     PaymentsModel(
//                   //       amount: "12",
//                   //       status: "completed",
//                   //       createdAt: 1682729875076 )
//                   //   ].map((payment) =>PaymentWidget()).toList()
//                   )
//             ],
//           );
//       ),
      
//       )
  
  
//             ),
//             Tab(
//               child: Text(
//                 'confirmed',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//             Tab(
//               child: Text(
//                 'sent',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildTab('Tab 1'),
//           _buildTab('Tab 2'),
//           _buildTab('Tab 3'),
//         ],
//       ),
//     );
//   }
// }
