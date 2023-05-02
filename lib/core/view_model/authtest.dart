// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_application_test/view/auth/login_screen.dart';
// import 'package:flutter_application_test/view/home/home_screen.dart';

// class AuthTest extends StatelessWidget {
//   const AuthTest({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           //user logged in
//           if (snapshot.hasData) {
//             return HomeScreen();
//           } else {
//             return loginScreen();
//           }
//         },
//       ),
//     );
//   }
// }
