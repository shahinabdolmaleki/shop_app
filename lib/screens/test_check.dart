import 'package:flutter/material.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/data/repository/authentication_repository.dart';
import 'package:shop_app/util/auth_manager.dart';

class ChechTest extends StatelessWidget {
  const ChechTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsApp.blue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: () async {
                  // ignore: unused_local_variable
                  var either = await AuthrnticationRepository()
                      .login('shahinmaleki2', '12345678');
                },
                child: const Text(
                  'login',
                  style: TextStyle(fontFamily: 'shabnamBold', fontSize: 16),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsApp.green,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: () async {
                  Authmanager.logOut();
                },
                child: const Text(
                  'logout',
                  style: TextStyle(fontFamily: 'shabnamBold', fontSize: 16),
                )),
            ValueListenableBuilder(
              valueListenable: Authmanager.authchangenotifier,
              builder: (context, value, child) {
                if (value == null) {
                  return const Text('شما وارد نشده اید');
                } else {
                  return const Text('شما وارد شده اید');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
