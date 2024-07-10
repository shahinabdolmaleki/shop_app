import 'package:dio/dio.dart';
import 'package:shop_app/data/model/product.dart';
import 'package:shop_app/di/di.dart';
import 'package:shop_app/util/api_exeption.dart';

abstract class IcategoryProductDatasource {
  Future<List<Product>> getproductbycategoryid(String categoryId);
}

class Categoryproductremote extends IcategoryProductDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<Product>> getproductbycategoryid(String categoryId) async {
    try {
      Map<String, String> qparams = {'filter': 'category="$categoryId"'};
      Response<dynamic> respones;

      if (categoryId == '78q8w901e6iipuk') {
        respones = await _dio.get('collections/products/records');
      } else {
        respones = await _dio.get('collections/products/records',
            queryParameters: qparams);
      }

      return respones.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown erorr');
    }
  }
}
