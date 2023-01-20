import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fic_mini_project/data/models/cart_model.dart';
import 'package:fic_mini_project/data/models/user_model.dart';
import 'package:fic_mini_project/domain/entity/transaction.dart';

class TransactionModel extends Equatable {
  final UserModel user;
  final CartModel cart;
  final int usePoint;
  final int endTotalPrice;
  final String paymentMethod;
  final DateTime createdAt;

  const TransactionModel({
    required this.user,
    required this.cart,
    required this.usePoint,
    required this.endTotalPrice,
    required this.paymentMethod,
    required this.createdAt,
  });

  factory TransactionModel.fromSnapshot(DocumentSnapshot doc) =>
      TransactionModel(
        user: UserModel.fromMap(doc.get('user')),
        cart: CartModel.fromMap(doc.get('cart')),
        usePoint: doc.get('use_point'),
        endTotalPrice: doc.get('end_total_price'),
        paymentMethod: doc.get('method_payment'),
        createdAt: DateTime.parse(doc.get('created_at')),
      );

  factory TransactionModel.fromEntity(TransactionEntity transaction) =>
      TransactionModel(
        user: UserModel.fromEntity(transaction.user),
        cart: CartModel.fromEntity(transaction.cart),
        usePoint: transaction.usePoint,
        endTotalPrice: transaction.endTotalPrice,
        paymentMethod: transaction.paymentMethod,
        createdAt: transaction.createdAt,
      );

  Map<String, dynamic> toDocument() => {
        'user': user.toDocument(),
        'cart': cart.toMap(),
        'use_point': usePoint,
        'end_total_price': endTotalPrice,
        'method_payment': paymentMethod,
        'created_at': createdAt.toIso8601String(),
      };

  TransactionEntity toEntity() => TransactionEntity(
        user: user.toEntity(),
        cart: cart.toEntity(),
        usePoint: usePoint,
        endTotalPrice: endTotalPrice,
        paymentMethod: paymentMethod,
        createdAt: createdAt,
      );

  @override
  List<Object?> get props => [
        user,
        cart,
        usePoint,
        endTotalPrice,
        paymentMethod,
        createdAt,
      ];
}
