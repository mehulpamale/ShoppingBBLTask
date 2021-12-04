import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_bbl_task/consts/constants.dart';
import 'package:shopping_bbl_task/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:shopping_bbl_task/cubit/product_list/product_list_cubit.dart';
import 'package:shopping_bbl_task/cubit/user/user_auth_cubit.dart';
import 'package:shopping_bbl_task/models/user_model.dart';
import 'package:shopping_bbl_task/widgets/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await userTest();
  // await addUser();
  runApp(const MyApp());
}

Future userTest() async {
  var fireStore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance.currentUser!;
  // await fireStore.collection("carts").doc(auth.uid).set({"uid": auth.uid});
  // debugPrint("user:" +
  //     json.decode((await fireStore.collection("carts").doc(auth.uid).get())
  //         .toString()));
  var coll = fireStore.collection("users");
  debugPrint('auth.uid: ${auth.uid}');
  await coll.doc(auth.phoneNumber).get().then(
      (value) => print('sout:' + UserModel.fromDocSnap(value).toString()));
  // var list = ds.docs.map((dSnap) => UserModel.fromJson(dSnap.data())).toList();
  // debugPrint('list: ${list}');
  //   .add(
  // {
  //   'uid': FirebaseAuth.instance.currentUser!.uid,
  //   'number': FirebaseAuth.instance.currentUser!.phoneNumber
  // },
  // );
  // debugPrint(ds);
}

Future addUser() async {
  debugPrint('addUser');
  var firestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  var users = firestore.collection(coll_users);
  await users.doc(auth.currentUser!.phoneNumber).set({'0': 1});
  var userList = await firestore.collection(coll_users).get().then((value) =>
      value.docs
          .map((e) => e
              .data()
              .map((key, value) => MapEntry(int.parse(key), value as int)))
          .toList());
  debugPrint('userList: ${userList}');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PhoneAuthCubit()),
        BlocProvider(create: (_) => UserAuthCubit()),
        BlocProvider(create: (_) => ProductListCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Wrapper(),
      ),
    );
  }
}
