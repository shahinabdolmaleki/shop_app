import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/data/datasource/authenticatiob_datasoursce.dart';
import 'package:shop_app/di/di.dart';
import 'package:shop_app/util/api_exeption.dart';
import 'package:shop_app/util/auth_manager.dart';

abstract class Iauthrepository {
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm);
  Future<Either<String, String>> login(String username, String password);
}

class AuthrnticationRepository extends Iauthrepository {
  final IAuthenticationDatasource _dataSource = locator.get();
  // ignore: unused_field
  final SharedPreferences _sharedpref = locator.get();

  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _dataSource.register('shain123456', '12345678', '12345678');
      return right('ثبت نام انجام شد');
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _dataSource.login(username, password);
      if (token.isNotEmpty) {
        Authmanager.savetoken(token);
        return right('وارد شدید');
      } else {
        return left('khata');
      }
    } on ApiExeption catch (ex) {
      return left('${ex.message}');
    }
  }
}
