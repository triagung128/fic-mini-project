import 'package:fic_mini_project/domain/repositories/auth_repository.dart';

class GetLoginStatus {
  final AuthRepository repository;

  GetLoginStatus(this.repository);

  bool execute() {
    return repository.getLoginStatus();
  }
}
