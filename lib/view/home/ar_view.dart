import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../model/product_model.dart';

class AR_View extends StatelessWidget {
  final ProductModel? Model;
  const AR_View({this.Model});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("view in 3D"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor:
              Color.fromARGB(255, 0, 79, 170), // Change the app bar color here
        ),
        body: ModelViewer(
          src: Model!.ar!,
          alt: "",
          ar: true,
          autoRotate: true,
          cameraControls: true,
        ),
      ),
    );
  }
}
