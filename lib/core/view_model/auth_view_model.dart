//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:el_marsa/helper/local_storage_data.dart';
import 'package:el_marsa/model/user_model.dart';
import 'package:el_marsa/view/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../view/control_view.dart';
import '../services/firestore_user.dart';

class AuthViewModel extends GetxController {
  // int counter = 3;
  GoogleSignIn? _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth? _auth = FirebaseAuth.instance;
  //FacebookLogin? _facebookLogin = FacebookLogin();

  late String email, password, name;
  //late Rx<User?> _user = Rx<User?>(User?);
  Rxn<User?> _user = Rxn<User?>();

  String? get user => _user.value?.email;
  final LocalStorgeData localStorgeData = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _user.bindStream(_auth!.authStateChanges());
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void increment() {
    //counter++;
    update();
  }

  // void googleSignInMethod() async {
  //   final GoogleSignInAccount? googleUser = await _googleSignIn!.signIn();
  //   print(googleUser);

  //   GoogleSignInAuthentication? googleSignInAuthentication =
  //       await googleUser?.authentication;

  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     idToken: googleSignInAuthentication?.idToken,
  //     accessToken: googleSignInAuthentication?.accessToken,
  //   );

  //   // UserCredential? userCredential =
  //   await _auth?.signInWithCredential(credential);
  //   //print(UserCredential);
  // }
/////////
void googleSignInMethod() async {
  try {
  final GoogleSignInAccount? googleUser = await _googleSignIn!.signIn();
  print(googleUser);

  GoogleSignInAuthentication? googleSignInAuthentication =
      await googleUser?.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    idToken: googleSignInAuthentication?.idToken,
    accessToken: googleSignInAuthentication?.accessToken,
  );

  UserCredential? userCredential =
      await _auth?.signInWithCredential(credential);

  // if (userCredential != null) {
  //   final UserModel? existingUser =
  //       await FireStoreUser()
    //      .getCurentUser(userCredential.user!.uid);
    //      // FireStoreUser().getCurentUser(value.user!.uid).then((value) {
    // if (existingUser != null) {
    //   setUser(existingUser);
    // } else {
      UserModel newUser = UserModel(
        userId: userCredential?.user!.uid,
        userEmail: userCredential?.user!.email,
        userName: userCredential?.user!.displayName,
        userPic: userCredential?.user!.photoURL,
      );

      await FireStoreUser().addUserFireStore(newUser);
      setUser(newUser);
       Get.offAll(ControllView());

    
} catch (e) {
      print(e.toString());

      Get.snackbar(
        "error login acount ",
        e.toString().toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


//////


  void CreateUserWithEmailMethod() async {
    try {
      await _auth
          ?.createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        saveUser(user);
      });

      Get.offAll(ControllView());
    } catch (e) {
      print(e.toString());

      Get.snackbar(
        "error login acount ",
        e.toString().toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

//////////////////////////




/////////////////////////
  void EmailSignInMethod() async {
    try {
      await _auth
          ?.signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await FireStoreUser().getCurentUser(value.user!.uid).then((value) {
          setUser(UserModel.fromJason(value.data() as Map<dynamic, dynamic>));
          print(value.data());
        });
      });
      print("ok user data");

      Get.offAll(ControllView());
    } catch (e) {
      print("catvh");
      print(e.toString());
      Get.snackbar(
        "error login acount ",
        e.toString().toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //Sign Up method


  void saveUser(UserCredential user) async {
    UserModel userModel = UserModel(
      userId: user.user?.uid,
      userEmail: user.user?.email,
      userName: name,
      userPic: '',
    );
    await FireStoreUser()
        .addUserFireStore(userModel)
        .then((value) => Get.offAll(ControllView()));
    setUser(userModel);
  }

  // void setUser(UserModel userModel) async {
  //   final data = await localStorgeData.setUser(userModel);
  //   final userData = data?.data();
  //   if (userData != null) {
  //     userModel = UserModel.fromJason(userData as Map<String, dynamic>);
  //   }
  //   _user.value = userModel as User?;
  // }

  void setUser(UserModel userModel) async {
    print('USER EMail');
    print("from set user${userModel.userEmail}");
    await localStorgeData.setUser(userModel);
  }

  Future<void> signOut() async {
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
    localStorgeData.deletUser();
  }
}


  // void facebookSignInMethod() async {
  //   await _facebookLogin?.logIn(customPermissions: ['email']);
  // }

  // void EmailSignInMethod() async {
  //   try {
  //     await _auth
  //         ?.signInWithEmailAndPassword(email: email, password: password)
  //         .then((value) async {
  //       print("befor getCurrentuser");
  //       await FireStoreUser().getCurentUser(value.user!.uid).then((value) {
  //         final userData = value.data();
  //         if (userData != null) {
  //           setUser(UserModel.fromJason(userData as Map<String, dynamic>));
  //           print("ok user data");
  //           print(userData);
  //         }
  //       });
  //     });
  //     Get.offAll(() => ControllView());
  //   } catch (e) {
  //     print(e.toString());

  //     Get.snackbar(
  //       "error login acount ",
  //       e.toString().toString(),
  //       colorText: Colors.black,
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }

  // void EmailSignInMethod() async {
  //   try {
  //     await _auth
  //         ?.signInWithEmailAndPassword(email: email, password: password)
  //         .then((value) async {
  //       print("befor getCurrentuser");
  //       await FireStoreUser().getCurentUser(value.user!.uid).then((value) {
  //         final userData = value.data();
  //         if (userData != null) {
  //           setUser(UserModel.fromJason(userData as Map<String, dynamic>));
  //           print("ok user data");
  //           print(userData);
  //         }
  //       }).catchError((error) {
  //         print("Error getting user data: $error");
  //       });
  //     });
  //     Get.offAll(() => ControllView());
  //   } catch (e) {
  //     print(e.toString());

  //     Get.snackbar(
  //       "error login acount ",
  //       e.toString().toString(),
  //       colorText: Colors.black,
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }