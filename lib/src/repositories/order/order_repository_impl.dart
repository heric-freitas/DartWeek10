import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/order/order_model.dart';
import '../../models/order/order_status.dart';
import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio _dio;

  OrderRepositoryImpl(this._dio);

  @override
  Future<void> changeStatus(int id, OrderStatus status) async {
    try {
      await _dio.auth().put(
        '/orders/$id',
        data: {
          'status': status.acromyn,
        },
      );
    } on DioError catch (e, s) {
      log('Erro ao alterar status do pedido para ${status.acromyn}', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao alterar status do pedido para ${status.acromyn}');
    }
  }

  @override
  Future<List<OrderModel>> findAllOrders(DateTime dateTime,
      [OrderStatus? status]) async {
    try {
      final result = await _dio.auth().get(
        '/orders',
        queryParameters: {
          'date' : dateTime.toIso8601String(),
          if(status != null) 'status' : status.acromyn,
        }
      );
      return result.data.map<OrderModel>((e) => OrderModel.fromMap(e)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar pedidos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar pedidos');
    }
  }

  @override
  Future<OrderModel> getById(int id) async {
    try {
      final result = await _dio.auth().get(
        '/orders/$id',
       
      );
      return OrderModel.fromMap(result.data);
    } on DioError catch (e, s) {
      log('Erro ao buscar pedido', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar pedido');
    }
  }
}
