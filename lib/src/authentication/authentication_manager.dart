import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:memorize_wodrds/src/static/strings_data.dart';

class AuthenticationManager {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final DatabaseReference userRef = FirebaseDatabase.instance
          .reference()
          .child('users')
          .child(userCredential.user!.uid);
      userRef.child('uid').set(userCredential.user!.uid);

      return userCredential.user;
    }
    return null;
  }

  Future<void> checkUserRegistered() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
    } else {
      final uid = currentUser.uid;

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentReference userDocRef = firestore.collection(Strings.STR_FIRESTORE_USERS_COLLECTION).doc(uid);

      Map<String, dynamic> userData = {
        "name": currentUser.displayName,
        "email": currentUser.email,
      };

      await userDocRef.update(userData);
    }
  }

  // 현재 로그인된 사용자 UID 가져오기
  Future<String?> getCurrentUserUid() async {
    final user = _auth.currentUser;
    return user?.uid;
  }
}
