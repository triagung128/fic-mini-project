import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fic_mini_project/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<void> loginWithGoogle();
  bool isLogin();
  Future<void> logout();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRemoteDataSourceImpl({
    required this.googleSignIn,
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<void> loginWithGoogle() async {
    try {
      await googleSignIn.disconnect();
    } catch (_) {}

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
          point: 0,
        );
        await userCollection.set(newUser.toDocument());
      }
    } else {
      throw PlatformException(code: GoogleSignIn.kSignInCanceledError);
    }
  }

  @override
  bool isLogin() {
    return firebaseAuth.currentUser != null;
  }

  @override
  Future<void> logout() async {
    return await firebaseAuth.signOut();
  }
}
