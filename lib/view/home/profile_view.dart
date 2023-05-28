// ignore_for_file: unnecessary_null_comparison

import 'package:el_marsa/core/view_model/payment_view_model.dart';
import 'package:el_marsa/core/view_model/profile_view_model.dart';
import 'package:el_marsa/view/auth/login_screen.dart';
import 'package:el_marsa/widgets/profile_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../fournisseur/AdressConfirmation.dart';
import '../fournisseur/add_product_form.dart';
import '../fournisseur/dropdowntest.dart';
import '../fournisseur/edit_profile.dart';
import '../fournisseur/orderstabs.dart';
import '../fournisseur/testvalidation.dart';
import '../payments/admin_payment.dart/admin_payment_screen.dart';
import '../payments/payments_view.dart';

class ProfileView extends StatelessWidget {
  // const ProfileView({Key? key}) : super(key: key);

  final controller = Get.put(PaymentViewModel());
  //final profileController = Get.put(ProfileViewModel());

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
                          // IconButton(
                          //   icon: Icon(Icons.arrow_back_ios_sharp),
                          //   onPressed: () {},
                          // ),
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
                                    'assets/images/user.jpg',
                                  ),
                                )
                              : controller.userModel?.userPic == "default"
                                  ? CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                        'assets/images/user.jpg',
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          controller.userModel!.userPic!)),
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
                                },
                              ),
                              SizedBox(height: 16),
                              GetBuilder<PaymentViewModel>(
                                init: PaymentViewModel(),
                                initState: (_) {},
                                builder: (Controller) {
                                  return ProfileRow(
                                    icon: Icons.payments_outlined,
                                    text: "Admin Payment History ",
                                    onpressed: () async {
                                      await Controller.getPaymentHistoryAdmin();
                                      Get.to(() => AdminPaymentsScreen());
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: 16),
                              GetBuilder<PaymentViewModel>(
                                init: PaymentViewModel(),
                                initState: (_) {},
                                builder: (Controller) {
                                  return ProfileRow(
                                    icon: Icons.list,
                                    text: "payments",
                                    onpressed: () async {
                                      //
                                      // await Get.to(() => MyTabPage());
                                      await Controller.getPaymentHistory();
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: 16),
                              GetBuilder<PaymentViewModel>(
                                  init: PaymentViewModel(),
                                  builder: (controller) => ProfileRow(
                                        icon: Icons.edit,
                                        text: "add product",
                                        onpressed: () {
                                          // Get.to(Testvali());
                                          Get.to(AddProductScreen());
                                          //Get.to(DropdownExample());
                                          //  controller.makePayment();
                                        },
                                      )),
                              SizedBox(height: 16),
                              ProfileRow(
                                icon: Icons.list,
                                text: "Chat",
                                onpressed: () async {
                                  //
                                  // await Get.to(() => MyTabPage());
                                  await controller.AdminChatPanel();
                                },
                              ),
                              SizedBox(height: 16),
                              GetBuilder<PaymentViewModel>(
                                init: PaymentViewModel(),
                                initState: (_) {},
                                builder: (controller) {
                                  return ProfileRow(
                                    icon: Icons.edit,
                                    text: "Payment Managment",
                                    onpressed: () async {
                                      await controller.GetListsAdmin();
                                      // await controller
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: 16),
                              GetBuilder<PaymentViewModel>(
                                  init: PaymentViewModel(),
                                  builder: (controller) => ProfileRow(
                                        icon: Icons.edit,
                                        text: "Confirm Adress",
                                        onpressed: () {
                                          // Get.to(Testvali());
                                          Get.to(AddressConfirmationForm());
                                          //Get.to(DropdownExample());
                                          //  controller.makePayment();
                                        },
                                      )),
                              SizedBox(height: 16),
                              ProfileRow(
                                icon: Icons.edit,
                                text: "Edit Profile",
                                onpressed: () {
                                //  controller.getCurrentUser();
                                  controller.refrshUserData();
                                  // Get.to(Testvali());
                                  String? userName =
                                      controller.userModel!.userName;
                                  String? userEmail =
                                      controller.userModel!.userEmail;
                                  String userImage =
                                      controller.userModel!.userPic!;
                                  String userId = controller.userModel!.userId!;
                                  print("user image" + userImage);
                                  Get.to(EditProfile(
                                      userImage: userImage,
                                      userEmail: userEmail!,
                                      userName: userName!,
                                      userId: userId));
                                  //Get.to(DropdownExample());
                                  //  controller.makePayment();
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
