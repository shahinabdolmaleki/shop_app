import 'package:dio/dio.dart';
import 'package:shop_app/data/model/banner.dart';
import 'package:shop_app/di/di.dart';
import 'package:shop_app/util/api_exeption.dart';

abstract class IbannerDataSource {
  Future<List<BannerApp>> getbanners();
}

class BannerRemoteDatasource extends IbannerDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<BannerApp>> getbanners() async {
    try {
      var respons = await _dio.get('collections/banner/records');
      return respons.data['items']
          .map<BannerApp>((jsonObject) => BannerApp.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown erorr');
    }
  }
}
