import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? userName;
  String? userEmail;
  String? userPic;

  UserModel({this.userId, this.userName, this.userEmail, this.userPic});

  // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
  UserModel.fromJason(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    userId = map['userId'];
    userName = map['userName'];
    userEmail = map['userEmail'];
    userPic = map['userPic'];
  }

  toJason() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userPic': userPic,
    };
  }

  //coding with tea
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      userId: data["userId"],
      userName: data["userName"],
      userEmail: data["userEmail"],
      userPic: data["userPic"],
    );
  }
}
