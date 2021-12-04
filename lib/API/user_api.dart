import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shopping_bbl_task/consts/constants.dart';

class UserAPI {
  var auth = FirebaseAuth.instance;
  var fireStore = FirebaseFirestore.instance;

  Future<UserCredential> loginWithCredential(
      AuthCredential authCredential) async {
    return await auth.signInWithCredential(authCredential);
  }

  Future addUserToDB(String number) async {
    return fireStore.collection(coll_users).doc(number).set({});
  }

  Future logout() async {
    return await auth.signOut();
  }

  bool isLoggedIn() {
    debugPrint('UserAuthAPI.isLoggedIn');
    return auth.currentUser?.uid != null;
  }

  String getPhoneNumber() {
    return auth.currentUser!.phoneNumber!;
  }
}
