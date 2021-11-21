import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_bbl_task/models/product.dart';

class ProductAPI {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<List<Product>> getProducts() async {
    final coll = firestore.collection('shopping_list');
    QuerySnapshot querySnapshot = await coll.orderBy('product_id').get();
    final list = querySnapshot.docs
        .map((docSnap) => Product.fromDocumentSnapshot(docSnap))
        .toList();
    return list;
  }
}
