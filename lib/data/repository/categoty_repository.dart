import 'package:dartz/dartz.dart';
import 'package:shop_app/data/datasource/category_datasource.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/di/di.dart';
import 'package:shop_app/util/api_exeption.dart';

abstract class Icategoryepository {
  Future<Either<String, List<Category>>> getCategory();
}

class Categoryrepository extends Icategoryepository {
  final ICategoryDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Category>>> getCategory() async {
    try {
      var respons = await _datasource.getCategorys();
      return right(respons);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا متن موجود نیست');
    }
  }
}
