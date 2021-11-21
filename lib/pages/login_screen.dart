import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_bbl_task/models/product.dart';
import 'package:shopping_bbl_task/pages/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController numberTEC = TextEditingController();

  Future<List<Product>> test() async {
    var firestore = FirebaseFirestore.instance;
    var coll = firestore.collection('shopping_list');
    QuerySnapshot querySnapshot = await coll.orderBy('product_id').get();

    // for (var element in querySnapshot.docs) {
    //   await element.reference.delete();
    // }
    // for (var i = 0; i < 10; i++) {
    //   coll.add({
    //     'product_id': i,
    //     'name': 'Dettol',
    //     'image':
    //         'https://firebasestorage.googleapis.com/v0/b/shoppingcartbbl.appspot.com/o/dettol_soap.jpg?alt=media&token=6afc17ed-f9c3-44f5-b29f-1c5e11fda85c',
    //     'rate': 25,
    //     'quantity': 10
    //   });
    // }

    var list = querySnapshot.docs
        // ..sort((a, b) => a['product_id'] < b['product_id'])
        .map((docSnap) => Product.fromDocumentSnapshot(docSnap))
        .toList();
    print('list.: ${list.length}');
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login with OTP',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: numberTEC,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'enter phone number',
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (c) => const HomeScreen())),
                child: const Text('Login with OTP'))
          ]),
        ),
      ),
    );
  }
}
