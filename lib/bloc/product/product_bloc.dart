import 'package:bloc/bloc.dart';
import 'package:shop_app/bloc/product/product_event.dart';
import 'package:shop_app/bloc/product/product_state.dart';
import 'package:shop_app/data/model/card_item.dart';
import 'package:shop_app/data/repository/basket_repository.dart';
import 'package:shop_app/data/repository/product_detail_repository.dart';
import 'package:shop_app/di/di.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IBasketRepository _basketRepository = locator.get();
  final IproductDetailrepository _iproductDetailrepository = locator.get();

  ProductBloc() : super(ProductInitStat()) {
    on<ProductGetInitializedevent>((event, emit) async {
      emit(ProductLoadingState());
      var imageProduct =
          await _iproductDetailrepository.getproductimage(event.productId);
      var productvariants =
          await _iproductDetailrepository.getproductvarient(event.productId);
      var productcategory =
          await _iproductDetailrepository.getproductcategory(event.categoryId);
      var productproperty =
          await _iproductDetailrepository.getproductproperty(event.productId);

      emit(ProductResponseState(
          imageProduct, productvariants, productcategory, productproperty));
    });
    on<ProductAddTobasket>(((event, emit) {
      var basketitem = BasketItem(
          event.product.id,
          event.product.collectionId,
          event.product.thumbnail,
          event.product.discountPrice,
          event.product.price,
          event.product.name,
          event.product.categoryId);
      _basketRepository.addProductToBasket(basketitem);
    }));
  }
}
