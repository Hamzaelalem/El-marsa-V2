import 'package:el_marsa/view/auth/signUp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constance.dart';

import '../../core/view_model/auth_view_model.dart';
import '../../widgets/custom_SocialButton.dart';
import '../../widgets/custom_formButton.dart';
import '../../widgets/custom_formField.dart';
import '../../widgets/custom_text.dart';
import '../home/home_screen.dart';

class loginScreen extends GetWidget<AuthViewModel> {
  loginScreen({
    super.key,
  });

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomeText(
                      text: "welcome",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(SignUpScreen());
                      },
                      child: CustomeText(
                        text: "Sign Up ",
                        color: primaryColor,
                        alignment: Alignment.centerLeft,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CustomeText(
                  text: "sign in to continue",
                  fontSize: 14,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 60,
                ),
                CustomFormField(
                  text: "Email",
                  onSave: (value) {
                    controller.email = value!;
                  },
                  validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    }
                  
                ),
                SizedBox(
                  height: 25,
                ),
                CustomFormField(
                    text: "Password",
                    hint: " ********",
                    onSave: (value) {
                      controller.password = value!;
                    },
                                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    
                    }),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () {},
                  child: CustomeText(
                    text: 'Forget Password?',
                    alignment: Alignment.topRight,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormButton(
                  onPressed: () {
                    // SignUserIn();
                    // controller.EmailSignInMethod();
                    // _formkey.currentState?.save();
                    // if(_formkey.currentContext?.validate()) {

                    // }

                    _formkey.currentState?.save();
                    if (_formkey.currentState!.validate()) {
                      controller.EmailSignInMethod();
                    }
                    ;
                  },
                  text: "SIGN IN",
                ),
                SizedBox(
                  height: 15,
                ),
                CustomeText(
                  text: "-OR-",
                  alignment: Alignment.center,
                  fontSize: 20,
                ),
                SizedBox(
                  height: 25,
                ),
                // SocialButton(
                //   text: "Sign In With Facebook",
                //   icon: "assets/images/Facebook_icon.png",
                //   onPressed: () {},
                // ),
                SizedBox(
                  height: 16,
                ),
                SocialButton(
                  text: "Sign In With Google",
                  icon: "assets/images/google1.png",
                  onPressed: () {
                    // _googleSignIn.signIn().then((value) {
                    //   String userName = value!.displayName!;
                    // });
                    //  controller.googleSignInMethod();

                    controller.googleSignInMethod();

                    //Get.find<AuthViewModel>().user != null
                    // ? HomeScreen()
                    // : loginScreen();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
