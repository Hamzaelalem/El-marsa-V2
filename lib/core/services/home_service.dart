import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeService {
  final CollectionReference _CategorieCollectionRef =
      FirebaseFirestore.instance.collection('categories');
 
  final CollectionReference _ProductCollectionRef =
      FirebaseFirestore.instance.collection('products');

  // ignore: non_constant_identifier_names
  Future<List<QueryDocumentSnapshot<Object?>>> getCategorie() async {
    var value = await _CategorieCollectionRef.get();
   
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getProducts() async {
    var value = await _ProductCollectionRef.get();
   
    return value.docs;
  }
  
}
