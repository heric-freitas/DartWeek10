import 'dart:developer';
import 'dart:typed_data';

import 'package:mobx/mobx.dart';

import '../../../models/product_model.dart';
import '../../../repositories/products/products_repository.dart';
part 'product_detail_controller.g.dart';

enum ProductDetailStateStatus {
  inital,
  loading,
  loaded,
  error,
  errorLoadProduct,
  delete,
  saved,
  uploaded,
}

class ProductDetailController = ProductDetailControllerBase
    with _$ProductDetailController;

abstract class ProductDetailControllerBase with Store {
  final ProductsRepository _productsRepository;

  ProductDetailControllerBase(this._productsRepository);

  @readonly
  var _status = ProductDetailStateStatus.inital;

  @readonly
  String? _messageError;

  @readonly
  String? _imagePath;

  @readonly
  ProductModel? _productModel;

  @action
  Future<void> uploadImageProduct(Uint8List file, String fileName) async {
    _status = ProductDetailStateStatus.loading;
    _imagePath = await _productsRepository.uploadImageProduct(file, fileName);
    _status = ProductDetailStateStatus.uploaded;
  }

  @action
  Future<void> saveProduct(
    String name,
    double price,
    String description,
  ) async {
    try {
      _status = ProductDetailStateStatus.loading;
      final model = ProductModel(
        id: _productModel?.id,
        name: name,
        description: description,
        price: price,
        image: _imagePath!,
        enabled: _productModel?.enabled ?? true,
      );
      await _productsRepository.save(model);
      _status = ProductDetailStateStatus.saved;
    } catch (e, s) {
      log('Erro ao salvar o produto', error: e, stackTrace: s);
      _status = ProductDetailStateStatus.error;
      _messageError = 'Erro ao salvar o produto';
    }
  }

  @action
  Future<void> loadProduct(int? id) async {
    try {
      _status = ProductDetailStateStatus.loading;
      _imagePath = null;
      _productModel = null;
      if (id != null) {
        _productModel = await _productsRepository.getProduct(id);
        _imagePath = _productModel!.image;
      }
      _status = ProductDetailStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao carregar produto', error: e, stackTrace: s);
      _status = ProductDetailStateStatus.errorLoadProduct;
    }
  }

  @action
  Future<void> deleteProduct() async {
    try {
      _status = ProductDetailStateStatus.loading;
      if (_productModel != null && _productModel!.id != null) {
        await _productsRepository.deleteProduct(_productModel!.id!);
        _status = ProductDetailStateStatus.delete;
        return;
      }
      await Future.delayed(Duration.zero);
      _status = ProductDetailStateStatus.error;
      _messageError = 'Produto não cadastrado, não é permitido deletar produtos não cadastrados';
    } catch (e, s) {
      log('Erro ao deletar produto', error: e, stackTrace: s);
      _status = ProductDetailStateStatus.error;
      _messageError = 'Erro ao deletar produto';
    }
  }
}
