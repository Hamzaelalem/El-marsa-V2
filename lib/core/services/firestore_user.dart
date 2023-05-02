import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_marsa/model/user_model.dart';

class FireStoreUser {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUserFireStore(UserModel userModel) async {
    return await _userCollectionRef
        .doc(userModel.userId)
        .set(userModel.toJason());
  }

  Future<DocumentSnapshot> getCurentUser(String uid) async {
    return await _userCollectionRef.doc(uid).get();
  }
}
