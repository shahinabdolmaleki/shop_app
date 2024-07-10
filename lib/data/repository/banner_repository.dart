import 'package:dartz/dartz.dart';
import 'package:shop_app/data/datasource/banner_datasource.dart';
import 'package:shop_app/data/model/banner.dart';
import 'package:shop_app/di/di.dart';
import 'package:shop_app/util/api_exeption.dart';

abstract class Ibannerrepository {
  Future<Either<String, List<BannerApp>>> getbanner();
}

class BannerRepository extends Ibannerrepository {
  final IbannerDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<BannerApp>>> getbanner() async {
    try {
      var respons = await _dataSource.getbanners();
      return right(respons);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا متن موجود نیست');
    }
  }
}
