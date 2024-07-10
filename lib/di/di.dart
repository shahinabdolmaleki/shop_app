import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/data/datasource/basket_datasource.dart';
import 'package:shop_app/data/datasource/category_product_datasource.dart';
import 'package:shop_app/data/datasource/product_datasource.dart';
import 'package:shop_app/data/datasource/product_detail_datasource.dart';
import 'package:shop_app/data/repository/authentication_repository.dart';
import 'package:shop_app/data/repository/banner_repository.dart';
import 'package:shop_app/data/repository/basket_repository.dart';
import 'package:shop_app/data/repository/categoty_repository.dart';
import 'package:shop_app/data/repository/product_detail_repository.dart';
import 'package:shop_app/data/repository/product_repository.dart';

import '../bloc/basket/basket_bloc.dart';
import '../data/datasource/authenticatiob_datasoursce.dart';
import '../data/datasource/banner_datasource.dart';
import '../data/datasource/category_datasource.dart';
import '../data/repository/category_product_repository.dart';
import '../util/payment_handler.dart';
import '../util/url_handler.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  await _initComponents();

  _initDatasoruces();

  _initRepositories();

  locator
      .registerSingleton<BasketBloc>(BasketBloc(locator.get(), locator.get()));
}

Future<void> _initComponents() async {
  locator.registerSingleton<UrlHandler>(UrlLuncher());
  locator
      .registerSingleton<PaymentHandler>(ZarinpalPaymentHandler(locator.get()));
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}

void _initDatasoruces() {
  locator
      .registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());
  locator
      .registerFactory<ICategoryDatasource>(() => CategoryRemotDataSource());
  locator.registerFactory<IbannerDataSource>(() => BannerRemoteDatasource());
  locator.registerFactory<IproductDatasource>(() => ProductRemotDataSource());
  locator.registerFactory<IproductDetailDataSource>(
      () => ProductDetailRemotDataSource());
  locator.registerFactory<IcategoryProductDatasource>(
      () => Categoryproductremote());
  locator.registerFactory<IBasketDatasource>(() => BasketLocalDatasouce());
}

void _initRepositories() {
  locator.registerFactory<Iauthrepository>(() => AuthrnticationRepository());
  locator.registerFactory<Icategoryepository>(() => Categoryrepository());
  locator.registerFactory<Ibannerrepository>(() => BannerRepository());
  locator.registerFactory<Iproductepository>(() => Productsrepository());
  locator.registerFactory<IproductDetailrepository>(
      () => ProductDetailrepository());
  locator.registerFactory<Icategoryproduct>(
      () => Categoryproduct());
  locator.registerFactory<IBasketRepository>(() => BasketRepository());
}