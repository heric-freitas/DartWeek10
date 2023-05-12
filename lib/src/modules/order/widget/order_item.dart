import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/styles/text_styles.dart';
import '../../../models/order/order_model.dart';
import '../order_controller.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;
  const OrderItem({Key? key, required this.order,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final styles = context.textStyles;
    return InkWell(
      onTap: (){
        context.read<OrderController>().showDetailMOdal(order);
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text('Pedido ', style: styles.textBold,),
                    Text(order.id.toString(), style: styles.textExtraBold,),
                    Expanded(
                      child: Text(
                        order.status.name,
                        textAlign: TextAlign.end,
                        style: styles.textExtraBold.copyWith(color: order.status.color),
                      ),
                    ),
                    const SizedBox(
                      height: double.infinity,
                      width: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(
            thickness: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
