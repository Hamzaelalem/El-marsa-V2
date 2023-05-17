import 'package:el_marsa/core/view_model/auth_view_model.dart';
import 'package:el_marsa/view/auth/login_screen.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../constance.dart';
import '../../widgets/custom_formButton.dart';
import '../../widgets/custom_formField.dart';
import '../../widgets/custom_text.dart';

class SignUpScreen extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Get.off(loginScreen());
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  CustomeText(
                    text: "Sign Up",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomeText(
                    text: "sign up to continue",
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  CustomFormField(
                    text: "Name",
                    hint: "Hamza",
                    onSave: (value) {
                      controller.name = value!;
                    },
                    validator: (value) {
                      if (value == null) {
                        print("ERROR");
                      }
                      ;
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CustomFormField(
                    text: "Email",
                    onSave: (value) {
                      controller.email = value!;
                    },
                    validator: (value) {
                      if (value == null) {
                        print("ERROR");
                      }
                      ;
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CustomFormField(
                      text: "Password",
                      hint: "********",
                      onSave: (value) {
                        controller.password = value!;
                      },
                      validator: (value) {
                        if (value == null) {
                          print("ERROR");
                        }
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomFormButton(
                    onPressed: () {
                      _formkey.currentState?.save();
                      if (_formkey.currentState!.validate()) {
                        controller.CreateUserWithEmailMethod();
                      }
                      ;
                    },
                    text: "SIGN UP",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
