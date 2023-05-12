import 'dart:typed_data';

import '../../models/product_model.dart';

abstract class ProductsRepository {
  Future<List<ProductModel>> findAll(String? name);
  Future<ProductModel> getProduct(int id);
  Future<void> save(ProductModel model);
  Future<String> uploadImageProduct(Uint8List file, String filename);
  Future<void> deleteProduct(int id); 
}