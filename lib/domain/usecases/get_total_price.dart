import 'package:fic_mini_project/domain/repositories/cart_repository.dart';

class GetTotalPrice {
  final CartRepository repository;

  GetTotalPrice(this.repository);

  Future<int> execute() {
    return repository.getTotalPrice();
  }
}
