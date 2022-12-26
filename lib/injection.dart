import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fic_mini_project/data/datasources/auth_local_data_source.dart';
import 'package:fic_mini_project/data/datasources/auth_remote_data_source.dart';
import 'package:fic_mini_project/data/pf/preference_helper.dart';
import 'package:fic_mini_project/data/repositories/auth_repository_impl.dart';
import 'package:fic_mini_project/domain/repositories/auth_repository.dart';
import 'package:fic_mini_project/domain/usecases/get_role.dart';
import 'package:fic_mini_project/domain/usecases/get_current_user.dart';
import 'package:fic_mini_project/domain/usecases/get_login_status.dart';
import 'package:fic_mini_project/domain/usecases/login.dart';
import 'package:fic_mini_project/domain/usecases/logout.dart';
import 'package:fic_mini_project/domain/usecases/set_role.dart';
import 'package:fic_mini_project/presentation/blocs/auth/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
    () => AuthBloc(
      login: locator(),
      getLoginStatus: locator(),
      setRole: locator(),
      getRole: locator(),
      logout: locator(),
    ),
  );

  locator.registerLazySingleton(() => Login(locator()));
  locator.registerLazySingleton(() => GetCurrentUser(locator()));
  locator.registerLazySingleton(() => GetLoginStatus(locator()));
  locator.registerLazySingleton(() => SetRole(locator()));
  locator.registerLazySingleton(() => GetRole(locator()));
  locator.registerLazySingleton(() => Logout(locator()));

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      googleSignIn: locator(),
      firebaseAuth: locator(),
      firebaseFirestore: locator(),
    ),
  );
  locator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(preferencesHelper: locator()),
  );

  locator.registerLazySingleton<PreferenceHelper>(() => PreferenceHelper());

  locator.registerLazySingleton(() => GoogleSignIn(scopes: ['email']));
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
}
