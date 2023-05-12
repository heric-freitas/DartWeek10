import 'package:flutter/material.dart';

import '../../../core/extensions/formatter_extensions.dart';
import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../dto/order/order_dto.dart';
import '../order_controller.dart';
import 'order_bottom_bar.dart';
import 'order_info_label.dart';
import 'order_product_item.dart';

class OrderDetailModal extends StatefulWidget {
  final OrderController controller;
  final OrderDto order;
  const OrderDetailModal(
      {Key? key, required this.controller, required this.order})
      : super(key: key);

  @override
  State<OrderDetailModal> createState() => _OrderDetailModalState();
}

class _OrderDetailModalState extends State<OrderDetailModal> {
  void _closeModal() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth;
    return Material(
      color: Colors.black26,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        elevation: 10,
        child: Container(
          width: width * (width > 1200 ? .5 : .7),
          padding: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Detalhe do pedido',
                        textAlign: TextAlign.center,
                        style: context.textStyles.textTitle,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: _closeModal,
                        icon: const Icon(
                          Icons.close,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Nome do cliente: ',
                      style: context.textStyles.textBold,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.order.user.name,
                      style: context.textStyles.textRegular,
                    ),
                  ],
                ),
                const Divider(),
                ...widget.order.orderProducts
                    .map((e) => OrderProductItem(orderProduct: e))
                    .toList(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total do Pedido',
                        style: context.textStyles.textExtraBold
                            .copyWith(fontSize: 18),
                      ),
                      Text(
                        widget.order.orderProducts
                            .fold<double>(
                                0.0,
                                (previousValue, element) =>
                                    previousValue + element.totalPrice)
                            .currencyPTBR,
                        style: context.textStyles.textExtraBold
                            .copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                OrderInfoLabel(
                  label: 'Endereço de entrega:',
                  info: widget.order.address,
                ),
                const Divider(),
                OrderInfoLabel(
                  label: 'Forma de pagamento:',
                  info: widget.order.paymentTypeModel.name,
                ),
                const SizedBox(
                  height: 10,
                ),
                OrderBottomBar(controller: widget.controller, order: widget.order),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
