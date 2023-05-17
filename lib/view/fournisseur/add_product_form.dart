import 'dart:io';

import 'package:el_marsa/view/home/profile_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/view_model/profile_view_model.dart';
import '../../model/product_model.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  XFile? image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController oldPriceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController founisseurIdController = TextEditingController();
  final TextEditingController fournisseurNameController =
      TextEditingController();
  final TextEditingController arController = TextEditingController();

  final _productController = Get.put(ProductController());
  final profileController = Get.put(ProfileViewModel());
  late String imageFile;
  late String imageName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 46, 81),
        title: Text('Add Product'),
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
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: oldPriceController,
                  decoration: InputDecoration(
                    labelText: 'Old Price',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an old price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: stockController,
                  decoration: InputDecoration(
                    labelText: 'Stock',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a stock quantity';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Augment Reality Link',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Valid Link';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: ElevatedButton(
                        onPressed: () async {
                          await pickImage();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 4, 46, 81))),
                        child: Text('add a picture')),
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(height: 16.0),
                SizedBox(height: 16.0),
                //SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      // validate the form
                      final product = ProductModel(
                        name: nameController.text,
                        description: descriptionController.text,
                        price: priceController.text,
                        oldPrice: oldPriceController.text,
                        stock: stockController.text,
                        founisseurId: profileController. userModel!.userId,
                        fournisseurName: profileController. userModel!.userName,
                        ar: arController.text,
                      );

                      _productController.addProductToFirestore(
                          product, imageFile);
                      nameController.clear();
                      descriptionController.clear();
                      priceController.clear();
                      oldPriceController.clear();
                      stockController.clear();
                      arController.clear();
                      Get.snackbar("Success", "Product added Succeesfully");
                      //Get.back();
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 4, 46, 81))),
                  child: Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile.path;
        imageName = pickedFile.name;
        //print("pathhhhhhhhhhhhhh"+pickedFile.path);
      });
    }
  }
}

//import 'dart:html';

class ProductController extends GetxController {
  final _products = <ProductModel>[].obs;

  List<ProductModel> get products => _products;
  final storage = FirebaseStorage.instance;

  Future<void> addProductToFirestore(
      ProductModel product, String imageFile) async {
    try {
      final imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference ref =
          storage.ref().child('product_images/${imageFileName}');
      final UploadTask uploadTask = ref.putFile(File(imageFile));

      final TaskSnapshot taskSnapshot = await uploadTask;
      final String imageUrl = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('products').add({
        'name': product.name,
        'description': product.description,
        'image': product.image,
        'price': product.price,
        'oldPrice': product.oldPrice,
        'stock': product.stock,
        'founisseurId': product.founisseurId,
        'fournisseurName': product.fournisseurName,
        'image': imageUrl,
        'ar': product.ar,
      });
      print('Product added to Firestore successfully');
    } catch (e) {
      print('Error adding product to Firestore: $e');
    }
  }

  String? validator(String value) {
    if (value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }
}
