
import 'package:bloc/bloc.dart';
import 'package:shop_app/bloc/authentication/auth_event.dart';
import 'package:shop_app/bloc/authentication/auth_state.dart';
import 'package:shop_app/data/repository/authentication_repository.dart';
import 'package:shop_app/di/di.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStat> {
  final Iauthrepository _iauthrepository = locator.get();
  AuthBloc() : super(AuthInitiatState()) {
    on<AuthLoginRequest>(((event, emit) async {
      emit(AuthLoadingState());
      var respons =
          await _iauthrepository.login(event.username, event.password);
      emit(AuthResponseState(respons));
    }));
  }
}
