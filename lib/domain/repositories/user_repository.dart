import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/entity/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, String>> updateCurrentUser(User user, XFile? image);
}
