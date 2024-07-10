import 'package:dartz/dartz.dart';
import 'package:shop_app/data/datasource/category_product_datasource.dart';
import 'package:shop_app/data/model/product.dart';
import 'package:shop_app/di/di.dart';
import 'package:shop_app/util/api_exeption.dart';

abstract class Icategoryproduct {
  Future<Either<String, List<Product>>> getproducts(String categoryId);
}

class Categoryproduct extends Icategoryproduct {
  final IcategoryProductDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Product>>> getproducts(categoryId) async {
    try {
      var respons = await _datasource.getproductbycategoryid(categoryId);
      return right(respons);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا متن موجود نیست');
    }
  }
}
