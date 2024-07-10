import 'package:dartz/dartz.dart';
import 'package:shop_app/data/datasource/product_datasource.dart';
import 'package:shop_app/data/model/product.dart';
import 'package:shop_app/di/di.dart';
import 'package:shop_app/util/api_exeption.dart';

abstract class Iproductepository {
  Future<Either<String, List<Product>>> getproducts();
  Future<Either<String, List<Product>>> gethottest();
  Future<Either<String, List<Product>>> getbestsellers();
}

class Productsrepository extends Iproductepository {
  final IproductDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Product>>> getproducts() async {
    try {
      var respons = await _datasource.getProducts();
      return right(respons);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا متن موجود نیست');
    }
  }

  @override
  Future<Either<String, List<Product>>> getbestsellers() async{
   try {
      var respons = await _datasource.getbestsellers();
      return right(respons);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا متن موجود نیست');
    }
  }

  @override
  Future<Either<String, List<Product>>> gethottest() async{
 try {
      var respons = await _datasource.getHottest();
      return right(respons);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا متن موجود نیست');
    }
  }
}
