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

  factory UserModel.fromDocSnap(DocumentSnapshot<Map<String, dynamic>> dSnap) {
    var v;
    print('dSnap: ${dSnap.exists}');
    var cart =
        v = dSnap.data()!.map((key, value) => MapEntry(int.parse(key), value
            as int));
    print('v: ${v}');
    return UserModel(
      number: int.parse(dSnap.id),
      cart: cart,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        number: json["number"],
        cart: json["cart"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "cart": cart,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
