import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles.dart';
import '../../../dto/order/order_dto.dart';
import '../../../models/order/order_status.dart';
import '../order_controller.dart';

class OrderBottomBar extends StatelessWidget {
  final OrderController controller;
  final OrderDto order;
  const OrderBottomBar({
    Key? key,
    required this.controller,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        OrderBottomBarButton(
          onPressed: order.stateStatus == OrderStatus.confirmado
              ? () {
                  controller.changeStatus(OrderStatus.finalizado);
                }
              : null,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          buttomColor: Colors.blue,
          image: 'assets/images/icons/finish_order_white_ico.png',
          label: 'Finalizar',
        ),
        OrderBottomBarButton(
          onPressed: order.stateStatus == OrderStatus.pendentes
              ? () {
                  controller.changeStatus(OrderStatus.confirmado);
                }
              : null,
          borderRadius: BorderRadius.zero,
          buttomColor: Colors.green,
          image: 'assets/images/icons/confirm_order_white_icon.png',
          label: 'Confirmar',
        ),
        OrderBottomBarButton(
          onPressed: order.stateStatus != OrderStatus.cancelado &&
                  order.stateStatus != OrderStatus.finalizado
              ? () {
                  controller.changeStatus(OrderStatus.cancelado);
                }
              : null,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          buttomColor: Colors.red,
          image: 'assets/images/icons/cancel_order_white_icon.png',
          label: 'Cancelar',
        ),
      ],
    );
  }
}

class OrderBottomBarButton extends StatelessWidget {
  final BorderRadius borderRadius;
  final Color buttomColor;
  final String image;
  final String label;
  final VoidCallback? onPressed;
  const OrderBottomBarButton({
    super.key,
    required this.borderRadius,
    required this.buttomColor,
    required this.image,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                side: BorderSide(
                  color: onPressed != null ? buttomColor : Colors.transparent,
                ),
                backgroundColor: buttomColor,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius,
                )),
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(image),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  label,
                  style:
                      context.textStyles.textBold.copyWith(color: Colors.white),
                )
              ],
            )),
      ),
    );
  }
}
