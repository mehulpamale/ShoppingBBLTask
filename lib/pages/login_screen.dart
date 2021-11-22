import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_bbl_task/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:shopping_bbl_task/models/product_model.dart';
import 'package:shopping_bbl_task/pages/home_screen.dart';
import 'package:shopping_bbl_task/widgets/named_circular_progress_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController numberTEC = TextEditingController();
  var hintText = '';
  var buttonText = 'Request OTP';
  var infoText = '';
  var counter = 2.00;
  var tfReadOnly = false;
  var buttonClick = () {};

  @override
  void initState() {
    BlocProvider.of<PhoneAuthCubit>(context).tryLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
        builder: (c, s) {
          if (s is PhoneAuthInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (s is PhoneAuthUserLoggingIn) {
            return const Center(child: CircularProgressIndicator());
          } else if (s is PhoneAuthUserLoggedIn) {
            Navigator.pushReplacement(
                c, MaterialPageRoute(builder: (c) => HomeScreen()));
          } else if (s is PhoneAuthVerified) {
            return const Center(child: CircularProgressIndicator());
          } else if (s is PhoneAuthFailed) {
            return Center(
                child: Column(
              children: [
                Text('failure: ${s.failure}\nplease try again'),
                ElevatedButton(
                    onPressed: () => BlocProvider.of<PhoneAuthCubit>(context)
                        .emit(PhoneAuthUserNotLoggedIn()),
                    child: const Text('Retry'))
              ],
            ));
          } else if (s is PhoneAuthUserNotLoggedIn) {
            buttonClick = () {
              BlocProvider.of<PhoneAuthCubit>(context)
                  .loginWithOTP(numberTEC.text);
            };
            return loginScreen();
          } else if (s is PhoneAuthRequestingOTP) {
            return const NamedCircularProgressIndicator('requesting OTP');
          } else if (s is PhoneAuthCodeSentByServer) {
            infoText = 'Please enter the OTP received';
            buttonText = 'Verify OTP';
            buttonClick = () {
              BlocProvider.of<PhoneAuthCubit>(context)
                  .sendReceivedOTPForVerification(
                      numberTEC.text, s.verificationID, s.resendToken);
            };
            return loginScreen();
          } else if (s is PhoneAuthOTPSentForVerification) {
            return const NamedCircularProgressIndicator('verifying OTP');
          }
          return (const Center(child: Text('failure')));
        },
      ),
    );
  }

  Widget loginScreen() {
    return Center(
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
              readOnly: tfReadOnly,
              controller: numberTEC,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: hintText,
              )),
          const SizedBox(
            height: 10,
          ),
          Text(infoText),
          const SizedBox(height: 5),
          ElevatedButton(
              onPressed: buttonClick
              //     () {
              //   // spTest();
              //   // phoneTest();
              //   // Navigator.push(
              //   //   context, MaterialPageRoute(builder: (c) => const HomeScreen())
              //   // );
              // }
              ,
              child: Text(buttonText))
        ]),
      ),
    );
  }

  void spTest() async {
    var sp = await SharedPreferences.getInstance();
    print(await sp.setString('test', 'test'));
    print(await sp.get('test'));
  }

  void phoneTest() async {
    var auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
        phoneNumber: "+91 899-971-0251",
        verificationCompleted: (cred) {
          print('cred: ${cred}');
          auth.signInWithCredential(cred);
        },
        verificationFailed: (e) => print('failed: ${e}'),
        codeSent: (s, i) {
          print('codesent: $s | $i');
          setState(() {
            if (numberTEC.text.length == 6) {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: s, smsCode: numberTEC.text);
              print('codesent 1: ${credential}');
            }
          });
        },
        codeAutoRetrievalTimeout: (s) => print('timeout: ${s}'));
  }

  Future<List<ProductModel>> test() async {
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
        .map((docSnap) => ProductModel.fromDocumentSnapshot(docSnap))
        .toList();
    print('list.: ${list.length}');
    return list;
  }
}
