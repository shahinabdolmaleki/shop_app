import 'package:dartz/dartz.dart';
import 'package:shop_app/data/model/banner.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/data/model/product.dart';

abstract class HomeState {}

class HomeInitStat extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccesState extends HomeState {
  Either<String, List<BannerApp>> bannerList;
  Either<String, List<Category>> categoryList;
  Either<String, List<Product>> productList;
    Either<String, List<Product>> hottestproductList;
      Either<String, List<Product>> bestsellerproductList;


  HomeRequestSuccesState(this.bannerList, this.categoryList, this.productList,this.hottestproductList,this.bestsellerproductList);
}

