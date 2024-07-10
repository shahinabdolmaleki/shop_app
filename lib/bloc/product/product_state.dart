import 'package:dartz/dartz.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/data/model/product_image.dart';
import 'package:shop_app/data/model/product_properties.dart';
import 'package:shop_app/data/model/product_variant.dart';

abstract class ProductState {}

class ProductInitStat extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductResponseState extends ProductState {
  Either<String, List<ProductImage>> getproductimages;
  Either<String, List<ProductVariant>> getvariant;
  Either<String, Category> productcategory;
  Either<String, List<Property>> getproperty;

  ProductResponseState(this.getproductimages,this.getvariant,this.productcategory,this.getproperty);
}
