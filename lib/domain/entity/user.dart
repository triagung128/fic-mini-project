import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? photoUrl;
  final String? role;
  final int? point;

  const User({
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
}
