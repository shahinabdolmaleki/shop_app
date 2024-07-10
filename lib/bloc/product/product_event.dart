import 'package:shop_app/data/model/product.dart';

abstract class ProductEvent {}

class ProductGetInitializedevent extends ProductEvent {
  String productId;
  String categoryId;
  // String productname;
  ProductGetInitializedevent(this.productId, this.categoryId);
}

class ProductAddTobasket extends ProductEvent {
  Product product;
  ProductAddTobasket(this.product);
}
