import 'package:bloc/bloc.dart';
import 'package:shop_app/bloc/home/home_event.dart';
import 'package:shop_app/bloc/home/home_state.dart';
import 'package:shop_app/data/repository/banner_repository.dart';
import 'package:shop_app/data/repository/categoty_repository.dart';
import 'package:shop_app/data/repository/product_repository.dart';
import 'package:shop_app/di/di.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Ibannerrepository _ibannerrepository = locator.get();
  final Icategoryepository _icategoryepository = locator.get();
  final Iproductepository _iproductepository = locator.get();
  HomeBloc() : super(HomeInitStat()) {
    on<HomeGetInitializedData>((event, emit) async {
      emit(HomeLoadingState());
      var bannerList = await _ibannerrepository.getbanner();
      var categoryList = await _icategoryepository.getCategory();
      var productList = await _iproductepository.getproducts();
      var hotestproductlist = await _iproductepository.gethottest();
      var bestsellerproductlist = await _iproductepository.getbestsellers();
      emit(HomeRequestSuccesState(bannerList, categoryList, productList,
          hotestproductlist, bestsellerproductlist));
    });
  }
}
