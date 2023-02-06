import 'package:dartz/dartz.dart';
import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/data/datasources/auth_local_data_source.dart';
import 'package:fic_mini_project/data/datasources/auth_remote_data_source.dart';
import 'package:fic_mini_project/domain/entity/user.dart';
import 'package:fic_mini_project/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> loginWithGoogle() async {
    try {
      final result = await remoteDataSource.loginWithGoogle();
      return Right(result.toEntity());
    } on PlatformException catch (e) {
      if (e.code == GoogleSignIn.kNetworkError) {
        return const Left(
          GoogleSignInFailure('Failed to connect to the network'),
        );
      } else if (e.code == GoogleSignIn.kSignInCanceledError) {
        return const Left(GoogleSignInFailure(''));
      } else {
        return const Left(GoogleSignInFailure('Something went wrong'));
      }
    }
  }

  @override
  bool getLoginStatus() {
    return remoteDataSource.isLogin();
  }

  @override
  Future<void> logout() async {
    await localDataSource.removeRole();
    await remoteDataSource.logout();
  }

  @override
  Future<String?> getRole() async {
    try {
      return await localDataSource.getRole();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<void> setRole(String role) async {
    try {
      await localDataSource.setRole(role);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
