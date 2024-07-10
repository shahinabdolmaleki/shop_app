import 'package:bloc/bloc.dart';
import 'package:shop_app/bloc/category_product/category_prodact_event.dart';
import 'package:shop_app/bloc/category_product/category_prodact_state.dart';
import 'package:shop_app/data/repository/category_product_repository.dart';
import 'package:shop_app/di/di.dart';

class CategoryProductBloc extends Bloc<CategoryProductEvent, CategoryproductStat> {
  final Icategoryproduct _icategoryproduct = locator.get();

  CategoryProductBloc() : super(CategoryLoadingState()) {
    on<Categoryprosuctinitialize>((event, emit) async {
      var response = await _icategoryproduct.getproducts(event.categoryId);
      emit(CategoryRsponssuccesState(response));
    });
  }
  }

