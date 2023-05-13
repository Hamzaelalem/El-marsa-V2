//import 'dart:io';


import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/product_model.dart';

//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/product_model.dart';

//

//

class Testvali extends StatefulWidget {
  @override
  State<Testvali> createState() => _Testvali();
}

class _Testvali extends State<Testvali> {
  final _formKey = GlobalKey<FormState>();

  //final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _productController = Get.put(ProductController());
  XFile? image;
  //List<XFile> imageFile = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Form(
        key: _formKey,
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
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    pickImage();
                  },
                  child: Text("add pic"),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // validate the form
                      final product = ProductModel(
                          name: nameController.text,
                          description: descriptionController.text,
                          //imageFile: image
                          );
                      _productController.addProductToFirestore(product);
                      //Get.back();
                    }
                  },
                  child: Text('Add'),
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
        //imageFile = [];
        image = XFile(pickedFile.path);
        // imageFile.add(XFile(pickedFile.path));
        //Navigator.of(context).pop();
        print("susses: image picker");
      });
    }
  }
}

class ProductController extends GetxController {
  final _products = <ProductModel>[].obs;

  List<ProductModel> get products => _products;

  Future<void> addProductToFirestore(ProductModel product) async {
    try {
      await FirebaseFirestore.instance.collection('products').add({
        'name': product.name,
        'description': product.description,
        //'imageFile': product.image,
      });
      print('Product added to Firestore successfully');
    } catch (e) {
      print('Error adding product to Firestore: $e');
    }
  }
}

//

// List<XFile> imageFile = [];
//   Future<void> handlePickImageProfile(
//       BuildContext context, ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       imageFile = [];
//       imageFile.add(XFile(pickedFile.path));
//       update();
//       // ignore: use_build_context_synchronously
//       Navigator.of(context).pop();

//       print("susses: image picker");
//     } else {
//       print("error: image picker");
//       // ignore: use_build_context_synchronously
//       Navigator.of(context).pop();
//     }
//   }

//const Testvali({super.key});

// XFile? _image;
// void _pickImage() async {
//   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//   if (pickedFile != null) {
//      setState(() {
//       _image = XFile(pickedFile.path);
//     });
//   }
// }

// image to fire store
// class Testvali extends StatefulWidget {
//   @override
//   State<Testvali> createState() => _Testvali();
// }

// class _Testvali extends State<Testvali> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();

//   final _productController = Get.put(ProductController());
//   XFile? image;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Product'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 TextFormField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                     labelText: 'Name',
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a name';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 TextFormField(
//                   controller: descriptionController,
//                   decoration: InputDecoration(
//                     labelText: 'Description',
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a description';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () async {
//                     pickImage();
//                   },
//                   child: Text('Add Image'),
//                 ),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       // Validate the form
//                       final product = ProductModel(
//                         name: nameController.text,
//                         description: descriptionController.text,
//                       );
//                       _productController.addProductToFirestore(product, image);
//                       Get.back();
//                     }
//                   },
//                   child: Text('Add'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         image = XFile(pickedFile.path);
//       });
//     }
//   }
// }

// class ProductController extends GetxController {
//   final _products = <ProductModel>[].obs;

//   List<ProductModel> get products => _products;

//   Future<void> addProductToFirestore(ProductModel product, XFile? image) async {
//     try {
//       final docRef =
//           await FirebaseFirestore.instance.collection('products').add({
//         'name': product.name,
//         'description': product.description,
//       });

//       if (image != null) {
//         final storageRef =
//             FirebaseStorage.instance.ref().child('products').child(docRef.id);
//         await storageRef.putFile(File(image.path));

//         final downloadURL = await storageRef.getDownloadURL();
//         await docRef.update({'imageURL': downloadURL});
//       }

//       print('Product added to Firestore successfully');
//     } catch (e) {
//       print('Error adding product to Firestore: $e');
//     }
//   }
// }

//
