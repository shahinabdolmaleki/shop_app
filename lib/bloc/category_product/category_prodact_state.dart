import 'package:dartz/dartz.dart';
import 'package:shop_app/data/model/product.dart';

abstract class CategoryproductStat {}


class CategoryLoadingState extends CategoryproductStat{

}


class CategoryRsponssuccesState extends CategoryproductStat{

  Either<String, List<Product>> response;
  CategoryRsponssuccesState(this.response);

}


