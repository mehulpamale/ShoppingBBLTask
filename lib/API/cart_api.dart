import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_bbl_task/consts/constants.dart';
import 'package:shopping_bbl_task/models/product_model.dart';

class CartAPI {
  final firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getCart() async {
    var coll = firestore.collection(coll_shopping);
    QuerySnapshot querySnapshot = await coll.orderBy('product_id').get();
    final list = querySnapshot.docs
        .map((docSnap) => ProductModel.fromDocumentSnapshot(docSnap))
        .toList();
    return list;
  }

  Stream<Map<int, int>>(String phoneNumber){

  }
}
