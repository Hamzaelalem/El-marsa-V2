import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_marsa/core/view_model/cart_view_model.dart';
import 'package:el_marsa/helper/binding.dart';
import 'package:el_marsa/test/paymenttesttt.dart';
import 'package:el_marsa/view/auth/login_screen.dart';
import 'package:el_marsa/view/control_view.dart';
import 'package:el_marsa/view/home/ar_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

//chatbot
//import 'package:kommunicate_flutter/kommunicate_flutter.dart';
late SharedPreferences prefs1;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51N1zeiFLfuzTyfv8IxCjedvq9zzRvPVSmjHomozOJhGucypLfbzACn0gW6yqCRrYNO2MWRMVlIFEJEmFi9gBIGJ000uR8QKpgn';
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = Settings(
      persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  Get.put(CartViewModel());

  prefs1 = await SharedPreferences.getInstance();
  await dotenv.load(fileName: "assets/.env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      home: ControllView(),
      theme: ThemeData(fontFamily: 'Schregular'),
    );
  }
}
