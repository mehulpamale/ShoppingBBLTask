import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_bbl_task/models/product_model.dart';

class CartAPI {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<List<ProductModel>> getProducts() async {
    final coll = firestore.collection('users');
    QuerySnapshot querySnapshot = await coll.orderBy('product_id').get();
    final list = querySnapshot.docs
        .map((docSnap) => ProductModel.fromDocumentSnapshot(docSnap))
        .toList();
    return list;
  }
}
