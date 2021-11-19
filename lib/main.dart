import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopping_bbl_task/pages/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  test();
}

void test() async {
  FirebaseFirestore firestore = await FirebaseFirestore.instance;
  // var list = jsonDecode(
  //     await firestore.collection('shopping_list').toString());
  var list = await firestore
      .collection('shopping_list')
      .snapshots()
      .map((qSnap) => qSnap.docs.map((e) => e.data()));
  print(list);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
