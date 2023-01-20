import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:fic_mini_project/domain/entity/user.dart';

class UserModel extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? photoUrl;
  final int? point;

  const UserModel({
    required this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.point,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
        photoUrl,
        point,
      ];

  User toEntity() => User(
        id: id,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl,
        point: point,
      );

  factory UserModel.fromEntity(User user) => UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoUrl,
        point: user.point,
      );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) => UserModel(
        id: snapshot.get('id'),
        name: snapshot.get('name'),
        email: snapshot.get('email'),
        phoneNumber: snapshot.get('phoneNumber'),
        photoUrl: snapshot.get('photoUrl'),
        point: snapshot.get('point'),
      );

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        photoUrl: map['photoUrl'],
        point: map['point'],
      );

  Map<String, dynamic> toDocument() => {
        'id': id,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'photoUrl': photoUrl,
        'point': point,
      };
}
