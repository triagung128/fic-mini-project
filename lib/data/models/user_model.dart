import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fic_mini_project/domain/entity/user.dart';

class UserModel extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? photoUrl;

  const UserModel({
    required this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
        photoUrl,
      ];

  User toEntity() => User(
        id: id,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl,
      );

  factory UserModel.fromEntity(User user) => UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoUrl,
      );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) => UserModel(
        id: snapshot.get('id'),
        name: snapshot.get('name'),
        email: snapshot.get('email'),
        phoneNumber: snapshot.get('phoneNumber'),
        photoUrl: snapshot.get('photoUrl'),
      );

  Map<String, dynamic> toDocument() => {
        'id': id,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'photoUrl': photoUrl,
      };
}
