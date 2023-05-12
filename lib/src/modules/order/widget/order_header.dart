import 'package:flutter/material.dart';

import '../../../core/ui/widgets/base_header.dart';
import '../../../models/order/order_status.dart';
import '../order_controller.dart';

class OrderHeader extends StatefulWidget {
  final OrderController controller;
  const OrderHeader({Key? key, required this.controller}) : super(key: key);

  @override
  State<OrderHeader> createState() => _OrderHeaderState();
}

class _OrderHeaderState extends State<OrderHeader> {
  OrderStatus? _statusSelected;
  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'Adiministrar pedidos',
      addButton: false,
      filterWidget: DropdownButton<OrderStatus?>(
        value: _statusSelected,
        items: [
          const DropdownMenuItem(value: null, child: Text('Todos')),
          ...OrderStatus.values
              .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
              .toList()
        ],
        onChanged: (value) {
          setState(() {
            _statusSelected = value;
          });
          widget.controller..changeStatusFilter(value)..findOrders();
        },
      ),
    );
  }
}
