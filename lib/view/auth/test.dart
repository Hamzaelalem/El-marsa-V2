// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_application_test/core/view_model/auth_view_model.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';

// class second extends StatelessWidget {
//   const second({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Center(
            
//             child:
            
//              GetBuilder<AuthViewModel>(
//           init: AuthViewModel(),
//           initState: (_) {},
//           builder: (Valu) {
//             return Text("${Valu.counter}");
                  
//           },
//         )),



//         GetBuilder<AuthViewModel>(
//           builder: (val) {
//             return ElevatedButton(
//               onPressed: () {
//                 val.increment();
//               },
//               child: Text("Increment"),
          
          
//             );
//           },
//         )
//       ],
//     ));
//   }
// }
