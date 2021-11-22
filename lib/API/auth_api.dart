import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthAPI {
  final firestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  Future verifyPhoneNumber(
    phoneNumber,
    verificationCompleted,
    verificationFailed,
    codeSent,
    codeAutoRetrievalTimeout,
  ) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<UserCredential> loginWithCredential(AuthCredential authCredential) async {
    return await auth.signInWithCredential(authCredential);
  }
}
