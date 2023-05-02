// ignore_for_file: unnecessary_null_comparison

import 'package:el_marsa/core/view_model/profile_view_model.dart';
import 'package:el_marsa/view/auth/login_screen.dart';
import 'package:el_marsa/widgets/profile_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  // const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      init: ProfileViewModel(),
      builder: (controller) => controller.loading.value
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Color.fromARGB(255, 58, 86, 109),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios_sharp),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      color: Color.fromARGB(255, 58, 86, 109),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [],
                          ),
                          controller.userModel == null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(
                                    'assets/images/iphone14.png',
                                  ),
                                )
                              : controller.userModel?.userPic == "default"
                                  ? CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                        'assets/images/iphone14.png',
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                        'assets/images/iphone14.png',
                                      ),
                                    ),
                          SizedBox(height: 16),
                          Text(
                            controller.userModel!.userName!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            controller.userModel!.userEmail!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfileRow(
                                icon: Icons.edit,
                                text: "sign out",
                                onpressed: () {
                                  controller.signOut();
                                  Get.offAll(loginScreen());
                                },
                              ),
                              SizedBox(height: 16),
                              ProfileRow(
                                icon: Icons.girl,
                                text:
                                    "user id ${controller.userModel?.userName}",
                                onpressed: () {},
                              ),
                              SizedBox(height: 16),
                              ProfileRow(
                                icon: Icons.girl,
                                text: "Khadija",
                                onpressed: () {},
                              ),
                              SizedBox(height: 16),
                              // GetBuilder<PaymentsController>(
                              //     init: PaymentsController(),
                              //     builder: (controller) =>
                              ProfileRow(
                                icon: Icons.edit,
                                text: "pay",
                                onpressed: () {
                                  //  controller.makePayment();
                                },
                                //)
                              ),
                              SizedBox(height: 16),
                              ProfileRow(
                                icon: Icons.edit,
                                text: "Edit Profile",
                                onpressed: () {
                                 
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
