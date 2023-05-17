import 'dart:io';

import 'package:el_marsa/model/user_model.dart';
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

class EditProfile extends StatefulWidget {
  // EditProfile({super.key});

  late String userImage, userName, userEmail, userId;

  EditProfile(
      {required this.userImage,
      required this.userEmail,
      required this.userName,
      required this.userId});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //late String imageFile;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  XFile? image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController IdController = TextEditingController();

  final _productController = Get.put(ProductController());
  final profileController = Get.put(ProfileViewModel());

  late String userImage, userId;

  void initState() {
    nameController.text = widget.userName;
    EmailController.text = widget.userEmail;
    userImage = widget.userImage;
    userId = widget.userId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 46, 81),
        title: Text('Edit your Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                  userImage == null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                            'assets/images/user.jpg',
                          ),
                        )
                      : CircleAvatar(
                          radius: 50, backgroundImage: NetworkImage(userImage)),
                  SizedBox(height: 16),
                  SizedBox(height: 8),
                ],
              ),
            ),
            Form(
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
                        controller: EmailController,
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
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: ElevatedButton(
                              onPressed: () async {
                                // await pickImage();
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 4, 46, 81))),
                              child: Text('add a pic')),
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
                            final user = UserModel(
                              userName: nameController.text,
                              userEmail: EmailController.text,
                              userId: userId,
                            );

                            _productController.addProductToFirestore(
                              user,
                            );
                            //add imageFile in the constractor
                            Get.snackbar(
                                "Success", "Product added Succeesfully");
                            Get.back();
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 4, 46, 81))),
                        child: Text('Save changes'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//   Future<void> pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         imageFile = pickedFile.path;

//         //print("pathhhhhhhhhhhhhh"+pickedFile.path);
//       });
//     }
//   }
}

//import 'dart:html';

class ProductController extends GetxController {
  final _products = <ProductModel>[].obs;

  List<ProductModel> get products => _products;
  final storage = FirebaseStorage.instance;

  Future<void> addProductToFirestore(UserModel user) async {
    // add imageFile in the constractor
    try {
      // final imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
      // final Reference ref =
      //     storage.ref().child('users_images/${imageFileName}');
      // final UploadTask uploadTask = ref.putFile(File(imageFile));

      // final TaskSnapshot taskSnapshot = await uploadTask;
      // final String imageUrl = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.userId)
          .update({'userName': user.userName, 'userEmail': user.userEmail});

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
