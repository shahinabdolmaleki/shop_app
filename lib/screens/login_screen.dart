import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/authentication/auth_bloc.dart';
import 'package:shop_app/bloc/authentication/auth_event.dart';
import 'package:shop_app/bloc/authentication/auth_state.dart';
import 'package:shop_app/constants/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _usernametextcontroler = TextEditingController();
  final _passwordTextControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: ColorsApp.blue,
          body: BlocProvider(
            create: ((context) => AuthBloc()),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/icon_application.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'اپل شاپ',
                        style: TextStyle(
                            fontFamily: 'shabnam',
                            color: Colors.white,
                            fontSize: 24),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _usernametextcontroler,
                          textDirection: TextDirection.rtl,
                          decoration: const InputDecoration(
                            labelText: 'نام کاربری',
                            labelStyle: TextStyle(
                                fontFamily: 'shabnam',
                                fontSize: 18,
                                color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.blue),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _passwordTextControler,
                          textDirection: TextDirection.rtl,
                          decoration: const InputDecoration(
                            labelText: 'کلمه عبور',
                            labelStyle: TextStyle(
                                fontFamily: 'shabnam',
                                fontSize: 18,
                                color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.blue),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<AuthBloc, AuthStat>(
                            builder: ((context, state) {
                          if (state is AuthInitiatState) {
                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(
                                        fontFamily: 'shabnam', fontSize: 18),
                                    minimumSize: const Size(200, 40),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                onPressed: () {
                                  BlocProvider.of<AuthBloc>(context).add(
                                      AuthLoginRequest(
                                          _usernametextcontroler.text,
                                          _passwordTextControler.text));
                                },
                                child: const Text(
                                  'ورود به حساب کاربری',
                                ));
                          }
                          if (state is AuthLoadingState) {
                            return const CircularProgressIndicator();
                          }
                          if (state is AuthResponseState) {
                            Text widget = const Text('');
                            state.response.fold((l) {
                              widget = Text(l);
                            }, (r) {
                              widget = Text(r);
                            });
                            return widget;
                          }
                          return const Text('خطای نا مشخص');
                        })),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
