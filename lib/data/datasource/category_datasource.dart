import 'package:dio/dio.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/di/di.dart';
import 'package:shop_app/util/api_exeption.dart';

abstract class ICategoryDatasource {
  Future<List<Category>> getCategorys();
}

class CategoryRemotDataSource extends ICategoryDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<Category>> getCategorys() async {
    try {
      var respons = await _dio.get('collections/category/records');
      return respons.data['items']
          .map<Category>((jsonObject) => Category.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown erorr');
    }
  }
}
