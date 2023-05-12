import 'package:flutter/material.dart';

enum OrderStatus {
  pendentes('Pendente', 'P', Colors.blue),
  confirmado('Confirmado', 'C', Colors.green),
  finalizado('Finalizado', 'D', Colors.black),
  cancelado('Cancelado', 'R', Colors.red);

  final String name;
  final String acromyn;
  final Color color;

  const OrderStatus(this.name, this.acromyn, this.color);

  static OrderStatus parse(String acromyn) {
    return values.firstWhere((element) => element.acromyn == acromyn);
  }
}
