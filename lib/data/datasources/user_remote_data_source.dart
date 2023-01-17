import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fic_mini_project/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getCurrentUser();
  Future<void> updateCurrentUser(UserModel user, XFile? image);
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  UserRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  @override
  Future<UserModel> getCurrentUser() async {
    final currentUser = firebaseAuth.currentUser!;
    final userCollection =
        firebaseFirestore.collection('users').doc(currentUser.uid);
    final documentSnapshot = await userCollection.get();
    return UserModel.fromSnapshot(documentSnapshot);
  }

  @override
  Future<void> updateCurrentUser(UserModel user, XFile? image) async {
    if (image != null) {
      final fileExtension = image.name.split('.').last;
      final fileName = 'profile.$fileExtension';
      final file = File(image.path);

      final storageRef = firebaseStorage.ref(user.id).child(fileName);
      await storageRef.putFile(file);
      final imageUrl = await storageRef.getDownloadURL();

      user = UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        photoUrl: imageUrl,
        point: user.point,
      );
    }

    firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toDocument());
  }
}
