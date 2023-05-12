import '../../../dto/order/order_dto.dart';
import '../../../dto/order/order_product_dto.dart';
import '../../../models/order/order_model.dart';
import '../../../models/payment_type_model.dart';
import '../../../models/user_model.dart';
import '../../../repositories/payment_type/payment_type_repository.dart';
import '../../../repositories/products/products_repository.dart';
import '../../../repositories/user/user_repository.dart';
import 'get_order_by_id.dart';

class GetOrderByIdImpl implements GetOrderById {
  final PaymentTypeRepository _paymentTypeRepository;
  final UserRepository _userRepository;
  final ProductsRepository _productsRepository;

  GetOrderByIdImpl(this._paymentTypeRepository, this._userRepository,
      this._productsRepository);

  @override
  Future<OrderDto> call(OrderModel order) => _orderDtoParse(order);

  Future<OrderDto> _orderDtoParse(OrderModel model) async {
    final start = DateTime.now();
    final paymentTypeFuture =
        _paymentTypeRepository.getById(model.paymentTypeId);
    final userFuture = _userRepository.getById(model.userId);
    final orderProductsFuture = _orderProductParse(model);

    print(
        'Calculando tempo no meio: ${DateTime.now().difference(start).inMilliseconds}');
    final responses = await Future.wait([
      paymentTypeFuture,
      userFuture,
      orderProductsFuture,
    ]);
    
    print(
        'Calculando tempo: ${DateTime.now().difference(start).inMilliseconds}');
    return OrderDto(
      id: model.id,
      date: model.date,
      stateStatus: model.status,
      orderProducts: responses[2] as List<OrderProductDto>,
      user: responses[1] as UserModel,
      address: model.address,
      cpf: model.cpf,
      paymentTypeModel: responses[0] as PaymentTypeModel,
    );
  }

  Future<List<OrderProductDto>> _orderProductParse(OrderModel model) async {
    final start = DateTime.now();
    final orderProducts = <OrderProductDto>[];
    final productsFuture = model.orderProducts
        .map((e) => _productsRepository.getProduct(e.productId))
        .toList();

    print(
        'Calculando tempo _orderProductParse no meio: ${DateTime.now().difference(start).inMilliseconds}');
    final products = await Future.wait(productsFuture, eagerError: true);
    print(
        'Calculando tempo _orderProductParse pos wait: ${DateTime.now().difference(start).inMilliseconds}');
    for (var i = 0; i < model.orderProducts.length; i++) {
      final orderProduct = model.orderProducts[i];
      final productDto = OrderProductDto(
        productModel: products[i],
        amount: orderProduct.amount,
        totalPrice: orderProduct.totalPrice,
      );
      orderProducts.add(productDto);
    }
    print(
        'Calculando tempo _orderProductParse no final: ${DateTime.now().difference(start).inMilliseconds}');
    return orderProducts;
  }
}
