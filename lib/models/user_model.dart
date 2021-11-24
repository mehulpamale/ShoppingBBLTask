// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.number,
    required this.cart,
  });

  final int number;
  final Map<int, int> cart;

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot snap) => UserModel(
        number: snap["number"],
        cart: snap["cart"],
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        number: json["number"],
        cart: json["cart"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "cart": cart,
      };
}

void main() {
  userTest();
}

userTest() async {
  var firebase = FirebaseFirestore.instance;
  var coll = firebase.collection('JmCxuoye6dhVwGvtgMvIK7Bmmn92');
  for (var i = 0; i < 5; i++) {
    coll.add({
      'cart': {0: 3},
      'number': 0123456789
    });
  }
}
