import 'package:bloc/bloc.dart';
import 'package:shop_app/bloc/category/category_event.dart';
import 'package:shop_app/bloc/category/category_state.dart';
import 'package:shop_app/data/repository/categoty_repository.dart';
import 'package:shop_app/di/di.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryStat> {
  final Icategoryepository _icategoryepository = locator.get();
  CategoryBloc() : super(CategoryInitState()) {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(CategoryLoadingState());
    on<CategoryRequestList>((event, emit) async {
      var response = await _icategoryepository.getCategory();
      emit(CategoryRsponsState(response));
    });
  }
}
