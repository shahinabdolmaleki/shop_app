import 'package:dartz/dartz.dart';
import 'package:shop_app/data/datasource/product_detail_datasource.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/data/model/product_image.dart';
import 'package:shop_app/data/model/product_properties.dart';
import 'package:shop_app/data/model/product_variant.dart';
import 'package:shop_app/data/model/varianttype.dart';
import 'package:shop_app/di/di.dart';
import 'package:shop_app/util/api_exeption.dart';

abstract class IproductDetailrepository {
  Future<Either<String, List<ProductImage>>> getproductimage(String productId);
  Future<Either<String, List<VariantType>>> getvarianttype();
  Future<Either<String, List<ProductVariant>>> getproductvarient(
      String productId);
  Future<Either<String, Category>> getproductcategory(String categoryId);
  Future<Either<String, List<Property>>> getproductproperty(String productId);
}

class ProductDetailrepository extends IproductDetailrepository {
  final IproductDetailDataSource _datasource = locator.get();
  @override
  Future<Either<String, List<ProductImage>>> getproductimage(
      String productId) async {
    try {
      var respons = await _datasource.getGallery(productId);
      return right(respons);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا متن موجود نیست');
    }
  }

  @override
  Future<Either<String, List<VariantType>>> getvarianttype() async {
    try {
      var respons = await _datasource.getvarianttyps();
      return right(respons);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا متن موجود نیست');
    }
  }

  @override
  Future<Either<String, List<ProductVariant>>> getproductvarient(
      String productId) async {
    try {
      var respons = await _datasource.getproductvarians(productId);
      return right(respons);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا متن موجود نیست');
    }
  }

  @override
  Future<Either<String, Category>> getproductcategory(String categoryId) async {
    try {
      var respons = await _datasource.getproductcategorydata(categoryId);
      return right(respons);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا متن موجود نیست');
    }
  }

  @override
  Future<Either<String, List<Property>>> getproductproperty(
      String productId) async {
    try {
      var respons = await _datasource.getproductproperty(productId);
      return right(respons);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا متن موجود نیست');
    }
  }



}
