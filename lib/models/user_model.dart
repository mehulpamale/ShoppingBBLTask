import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  userTest();
}

userTest() async {
  var firebase = FirebaseFirestore.instance;
  var coll = firebase.collection('JmCxuoye6dhVwGvtgMvIK7Bmmn92');
  for (var i = 0; i < 5; i++) {
    coll.add({
      'cart': {0: 3},
      'number': 0123456789
    });
  }
}
