import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:fic_mini_project/domain/entity/user.dart';

class UserModel extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? photoUrl;
  final String? role;
  final int? point;

  const UserModel({
    required this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.role,
    this.point,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
        photoUrl,
        role,
        point,
      ];

  User toEntity() => User(
        id: id,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl,
        role: role,
        point: point,
      );

  factory UserModel.fromEntity(User user) => UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoUrl,
        role: user.role,
        point: user.point,
      );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) => UserModel(
        id: snapshot.get('id'),
        name: snapshot.get('name'),
        email: snapshot.get('email'),
        phoneNumber: snapshot.get('phoneNumber'),
        photoUrl: snapshot.get('photoUrl'),
        role: snapshot.get('role'),
        point: snapshot.get('point'),
      );

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        photoUrl: map['photoUrl'],
        role: map['role'],
        point: map['point'],
      );

  Map<String, dynamic> toDocument() => {
        'id': id,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'photoUrl': photoUrl,
        'role': role,
        'point': point,
      };
}
