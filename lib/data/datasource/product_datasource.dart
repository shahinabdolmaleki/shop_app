// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:shop_app/data/model/product.dart';
import 'package:shop_app/di/di.dart';
import 'package:shop_app/util/api_exeption.dart';

abstract class IproductDatasource {
  Future<List<Product>> getProducts();
  Future<List<Product>> getHottest();
  Future<List<Product>> getbestsellers();
}

class ProductRemotDataSource extends IproductDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<Product>> getProducts() async {
    try {
      var respons = await _dio.get('collections/products/records');
      return respons.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown erorr');
    }
  }

  @override
  Future<List<Product>> getHottest() async {
    // ignore: unused_local_variable
    Map<String, String> qparams = {'filter': 'popularity="Hotest"'};
    try {
      var respons = await _dio.get('collections/products/records');
      return respons.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown erorr');
    }
  }

  @override
  Future<List<Product>> getbestsellers() async {
    Map<String, String> qparams = {'filter': 'popularity="Best Seller"',};
    try {
      var respons = await _dio.get('collections/products/records',queryParameters: qparams);
      return respons.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown erorr');
    }
  }
}
