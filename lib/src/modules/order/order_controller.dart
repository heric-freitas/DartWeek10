import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../dto/order/order_dto.dart';
import '../../models/order/order_model.dart';
import '../../models/order/order_status.dart';
import '../../repositories/order/order_repository.dart';
import '../../services/auth/order/get_order_by_id.dart';
part 'order_controller.g.dart';

enum OrderStateStatus {
  initial,
  loading,
  loaded,
  error,
  showDetailModal,
  statusChanged,
}

class OrderController = OrderControllerBase with _$OrderController;

abstract class OrderControllerBase with Store {
  final OrderRepository _orderRepository;
  final GetOrderById _getOrderById;

  OrderControllerBase(this._orderRepository, this._getOrderById) {
    final todayNow = DateTime.now();
    _today = DateTime(todayNow.year, todayNow.month, todayNow.day);
  }

  late final DateTime _today;

  @readonly
  OrderStatus? _orderStatus;

  @readonly
  var _orders = <OrderModel>[];

  @readonly
  var _status = OrderStateStatus.initial;

  @readonly
  String? _errorMessage;

  @readonly
  OrderDto? _orderSelected;

  @action
  Future<void> findOrders() async {
    try {
      _status = OrderStateStatus.loading;
      _orders = await _orderRepository.findAllOrders(_today, _orderStatus);
      _status = OrderStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar pedidos do dia', error: e, stackTrace: s);
      _status = OrderStateStatus.error;
      _errorMessage = 'Erro ao buscar pedidos do dia';
    }
  }

  @action
  Future<void> showDetailMOdal(OrderModel model) async {
    _status = OrderStateStatus.loading;
    _orderSelected = await _getOrderById(model);
    _status = OrderStateStatus.showDetailModal;
  }

  @action
  Future<void> changeStatus(OrderStatus status) async {
    _status = OrderStateStatus.loading;
    await _orderRepository.changeStatus(_orderSelected!.id, status);
    _status = OrderStateStatus.statusChanged;
  }

  @action
  void changeStatusFilter(OrderStatus? status) => _orderStatus = status;
}
