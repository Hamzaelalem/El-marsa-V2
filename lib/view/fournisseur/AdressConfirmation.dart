import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_marsa/core/view_model/payment_view_model.dart';
import 'package:el_marsa/core/view_model/profile_view_model.dart';
import 'package:el_marsa/model/adress_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/product_model.dart';

class AddressConfirmationForm extends StatefulWidget {
  const AddressConfirmationForm({super.key});

  @override
  State<AddressConfirmationForm> createState() =>
      _AddressConfirmationFormState();
}

class _AddressConfirmationFormState extends State<AddressConfirmationForm> {
  @override
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  XFile? image;
  final TextEditingController adressController = TextEditingController();
  final TextEditingController PhoneController = TextEditingController();
  final TextEditingController additionalController = TextEditingController();
  final TextEditingController RegionController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final _productController = Get.put(ProductController());
  final profileController = Get.put(ProfileViewModel());
  late String imageFile;
  late String imageName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 46, 81),
        title: Text('Add New Adress '),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: adressController,
                  decoration: InputDecoration(
                    labelText: 'adress',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a adress';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // SizedBox(height: 16.0),
                TextFormField(
                  controller: PhoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Valid Phone Number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // SizedBox(height: 16.0),

                SizedBox(height: 16.0),
                TextFormField(
                  controller: additionalController,
                  decoration: InputDecoration(
                    labelText: 'additional information',
                  ),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter a additional information';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: RegionController,
                  decoration: InputDecoration(
                    labelText: 'Region',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Region';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                    labelText: 'City',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a City';
                    }
                    return null;
                  },
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     alignment: Alignment.topLeft,
                //     child: ElevatedButton(
                //         onPressed: () async {
                //           await pickImage();
                //         },
                //         style: ButtonStyle(
                //             backgroundColor: MaterialStateProperty.all<Color>(
                //                 const Color.fromARGB(255, 4, 46, 81))),
                //         child: Text('add a picture')),
                //   ),
                // ),
                SizedBox(height: 16.0),
                SizedBox(height: 16.0),
                SizedBox(height: 16.0),
                //SizedBox(height: 10.0),
                Container(
                  height: 50,
                  child: GetBuilder<PaymentViewModel>(
                    init: PaymentViewModel(),
                    initState: (_) {},
                    builder: (controller) {
                      return ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            // validate the form
                            final adress = AddressModel(
                                address: adressController.text,
                                phoneNumber: PhoneController.text,
                                additionalInfo: additionalController.text,
                                region: RegionController.text,
                                city: cityController.text,
                                clientId: profileController.userModel!.userId!);

                            _productController.addAdressToFirestore(adress);

                            adressController.clear();
                            additionalController.clear();
                            PhoneController.clear();
                            RegionController.clear();
                            cityController.clear();

                            Get.snackbar(
                                "Success", "adress added Succeesfully");
                               controller.makePayment();

                            //Get.back();
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 4, 46, 81))),
                        child: Text('Checkout'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//import 'dart:html';

class ProductController extends GetxController {
  final _products = <ProductModel>[].obs;

  List<ProductModel> get products => _products;
  //final storage = FirebaseStorage.instance;

  Future<void> addAdressToFirestore(AddressModel adress) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('adresses')
          .where('clientId', isEqualTo: adress.clientId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Update existing document
        final docId = snapshot.docs.first.id;
        await FirebaseFirestore.instance
            .collection('adresses')
            .doc(docId)
            .update({
          'city': adress.city,
          'additionalInfo': adress.additionalInfo,
          'address': adress.address,
          'phoneNumber': adress.phoneNumber,
          'region': adress.region,
        });

        print('Address updated successfully');
      } else {
        // Create new document
        await FirebaseFirestore.instance.collection('adresses').add({
          'city': adress.city,
          'additionalInfo': adress.additionalInfo,
          'address': adress.address,
          'clientId': adress.clientId,
          'phoneNumber': adress.phoneNumber,
          'region': adress.region,
        });

        print('Address added successfully');
      }
    } catch (e) {
      print('Error adding/updating address: $e');
    }
  }

  String? validator(String value) {
    if (value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }
}
