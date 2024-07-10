import 'package:dartz/dartz.dart';
import 'package:shop_app/data/model/category.dart';

abstract class CategoryStat {}


class CategoryInitState extends CategoryStat{

}


class CategoryRsponsState extends CategoryStat{

  Either<String, List<Category>> response;
  CategoryRsponsState(this.response);

}


class CategoryLoadingState extends CategoryStat{
  
}