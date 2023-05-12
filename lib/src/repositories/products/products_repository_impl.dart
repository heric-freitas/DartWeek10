import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/product_model.dart';
import 'products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final CustomDio _dio;

  ProductsRepositoryImpl(this._dio);

  @override
  Future<void> deleteProduct(int id) async {
    try {
      await _dio.auth().put(
        '/products/$id',
        data: {
          'enabled': false,
        },
      );
    } on DioError catch (e, s) {
      log('Erro ao deletar produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar produto');
    }
  }

  @override
  Future<List<ProductModel>> findAll(String? name) async {
    try {
      final result = await _dio.auth().get(
        '/products',
        queryParameters: {
          if (name != null) 'name': name,
          'enabled': true,
        },
      );
      return result.data
          .map<ProductModel>((p) => ProductModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar produtos');
    }
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    try {
      final result = await _dio.auth().get(
            '/products/$id',
          );
      return ProductModel.fromMap(result.data);
    } on DioError catch (e, s) {
      log('Erro ao buscar produto $id', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar produto $id');
    }
  }

  @override
  Future<void> save(ProductModel model) async {
    try {
      final client = _dio.auth();
      final data = model.toMap();
      if (model.id != null) {
        await client.put('/products/${model.id}', data: data);
      } else {
        await client.post('/products', data: data);
      }
    } catch (e, s) {
      log('Erro ao salvar produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao salvar produto');
    }
  }

  @override
  Future<String> uploadImageProduct(Uint8List file, String filename) async {
    try {
      final formData = FormData.fromMap(
      {
        'file': MultipartFile.fromBytes(file, filename: filename),
      },
    );

    final response = await _dio.auth().post('/uploads', data: formData);
    return response.data['url'];
    } on DioError catch (e, s) {
      log('Erro ao subir uma imagem', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao subir uma imagem');
    }
  }
}
