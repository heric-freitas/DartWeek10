// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../../models/product_model.dart';

class OrderProductDto {
  final ProductModel productModel;
  final int amount;
  final double totalPrice;
  OrderProductDto({
    required this.productModel,
    required this.amount,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productModel': productModel.toMap(),
      'amount': amount,
      'totalPrice': totalPrice,
    };
  }

  factory OrderProductDto.fromMap(Map<String, dynamic> map) {
    return OrderProductDto(
      productModel: ProductModel.fromMap(map['productModel'] as Map<String,dynamic>),
      amount: map['amount'] as int,
      totalPrice: map['totalPrice'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderProductDto.fromJson(String source) => OrderProductDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
