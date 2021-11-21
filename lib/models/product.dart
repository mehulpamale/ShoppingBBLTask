// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product implements Equatable {
  Product({
    required this.rate,
    required this.quantity,
    required this.name,
    required this.productId,
    required this.image,
  });

  final int rate;
  final int quantity;
  final String name;
  final int productId;
  final String image;

  factory Product.fromJson(Map<String, dynamic> json) =>
      Product(
        rate: json["rate"],
        quantity: json["quantity"],
        name: json["name"],
        productId: json["product_id"],
        image: json["image"],
      );

  factory Product.fromDocumentSnapshot(DocumentSnapshot docSnap) =>
      Product(
        rate: docSnap["rate"],
        quantity: docSnap["quantity"],
        name: docSnap["name"],
        productId: docSnap["product_id"],
        image: docSnap["image"],
      );


  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() =>
      {
        "rate": rate,
        "quantity": quantity,
        "name": name,
        "product_id": productId,
        "image": image,
      };

  @override
  List<Object?> get props => [productId];

  @override
  bool? get stringify => true;
}
