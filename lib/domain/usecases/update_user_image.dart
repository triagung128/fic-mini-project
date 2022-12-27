import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/repositories/auth_repository.dart';

class UpdateUserImage {
  final AuthRepository repository;

  UpdateUserImage(this.repository);

  Future<Either<Failure, String>> execute(String fileName, File file) {
    return repository.updateUserImage(fileName, file);
  }
}
