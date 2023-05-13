// import 'package:flutter/material.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// import '../../model/product_model.dart';
// import 'package:image_picker/image_picker.dart';

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({super.key});

//   @override
//   State<AddProductScreen> createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//   XFile? image;
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController oldPriceController = TextEditingController();
//   final TextEditingController stockController = TextEditingController();
//   final TextEditingController founisseurIdController = TextEditingController();
//   final TextEditingController fournisseurNameController =
//       TextEditingController();

//   final _productController = Get.put(ProductController());
//   // String selectedImagePath = "";

//   // Future selectImageFromGallery() async {
//   //   XFile? file = await ImagePicker()
//   //       .pickImage(source: ImageSource.gallery, imageQuality: 10);
//   //   if (file != null) {
//   //     return file.path;
//   //   } else {
//   //     return '';
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Product'),
//       ),
//       body: Form(
//         key: _formkey,
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
//                 TextFormField(
//                   controller: priceController,
//                   decoration: InputDecoration(
//                     labelText: 'Price',
//                   ),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a price';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 TextFormField(
//                   controller: oldPriceController,
//                   decoration: InputDecoration(
//                     labelText: 'Old Price',
//                   ),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter an old price';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 TextFormField(
//                   controller: stockController,
//                   decoration: InputDecoration(
//                     labelText: 'Stock',
//                   ),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a stock quantity';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 SizedBox(height: 16.0),
//                 SizedBox(height: 10.0),
//                 ElevatedButton(
//                     onPressed: () async {
//                       // selectedImagePath = await selectImageFromGallery();
//                       // print('Image_Path:-');
//                       // print(selectedImagePath);
//                       // if (selectedImagePath != '') {
//                       //   Navigator.pop(context);
//                       //   setState(() {});
//                       // } else {
//                       //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       //     content: Text("No Image Selected !"),
//                       //   ));
//                       // }
//                       //XFile? image;
//                       //  Future pickImage() async {

//                       //  try {
//                       //         final image = await ImagePicker().pickImage(source: ImageSource.camera);
//                       //   if(image == null) return;
//                       //   final imageTemp = XFile(image.path);
//                       //   setState(() => this.image = imageTemp);
//                       //       } on PlatformException catch(e) {
//                       //         print('Failed to pick image: $e');
//                       //       }
//                       //     }

//                       final ImagePicker picker = ImagePicker();
//                       // Pick an image.
//                       final XFile? image =
//                           await picker.pickImage(source: ImageSource.gallery);
//                     },
//                     child: Text('add a pic1')),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formkey.currentState!.validate()) {
//                       // validate the form
//                       final product = ProductModel(
//                         name: nameController.text,
//                         description: descriptionController.text,
//                         price: priceController.text,
//                         oldPrice: oldPriceController.text,
//                         stock: stockController.text,
//                         founisseurId: "123test",
//                         fournisseurName: "hamza fix",
//                       );

//                       _productController.addProductToFirestore(product);
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
// }

// //import 'dart:html';

// class ProductController extends GetxController {
//   final _products = <ProductModel>[].obs;

//   List<ProductModel> get products => _products;

//   Future<void> addProductToFirestore(ProductModel product) async {
//     try {
//       await FirebaseFirestore.instance.collection('products').add({
//         'name': product.name,
//         'description': product.description,
//         'image': product.image,
//         'price': product.price,
//         'oldPrice': product.oldPrice,
//         'stock': product.stock,
//         'founisseurId': product.founisseurId,
//         'fournisseurName': product.fournisseurName,
//       });
//       print('Product added to Firestore successfully');
//     } catch (e) {
//       print('Error adding product to Firestore: $e');
//     }
//   }

  //  String? validator(String value) {
  //   if (value.isEmpty) {
  //     return 'Please this field must be filled';
  //   }
  //   return null;
  // }
// }




//



