import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fic_mini_project/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<void> loginWithGoogle();
  Future<UserModel> getCurrentUser();
  bool isLogin();
  Future<void> logout();
  Future<void> updateUser(UserModel user);
  Future<String> updateUserImage(String fileName, File file);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  AuthRemoteDataSourceImpl({
    required this.googleSignIn,
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  @override
  Future<void> loginWithGoogle() async {
    final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await firebaseAuth.signInWithCredential(credential);

      final currentUser = firebaseAuth.currentUser!;
      final userCollection =
          firebaseFirestore.collection('users').doc(currentUser.uid);
      final user = await userCollection.get();
      if (!user.exists) {
        final newUser = UserModel(
          id: currentUser.uid,
          name: currentUser.displayName,
          email: currentUser.email,
          phoneNumber: currentUser.phoneNumber,
          photoUrl: currentUser.photoURL,
        );
        await userCollection.set(newUser.toDocument());
      }
    } else {
      throw PlatformException(code: GoogleSignIn.kSignInCanceledError);
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final currentUser = firebaseAuth.currentUser!;
    final userCollection =
        firebaseFirestore.collection('users').doc(currentUser.uid);
    final documentSnapshot = await userCollection.get();
    return UserModel.fromSnapshot(documentSnapshot);
  }

  @override
  bool isLogin() {
    return firebaseAuth.currentUser != null;
  }

  @override
  Future<void> logout() async {
    return await firebaseAuth.signOut();
  }

  @override
  Future<void> updateUser(UserModel user) {
    return firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toDocument());
  }

  @override
  Future<String> updateUserImage(String fileName, File file) async {
    final uid = firebaseAuth.currentUser!.uid;
    final storageRef = firebaseStorage.ref(uid).child(fileName);
    await storageRef.putFile(file);
    return await storageRef.getDownloadURL();
  }
}
