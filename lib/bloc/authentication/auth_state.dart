import 'package:dartz/dartz.dart';

abstract class AuthStat {}


class AuthInitiatState extends AuthStat {}


class AuthLoadingState extends AuthStat {}

class AuthResponseState extends AuthStat {
  Either<String, String> response;
  AuthResponseState(this.response);
}
