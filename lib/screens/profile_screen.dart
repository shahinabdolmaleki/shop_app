import 'package:flutter/material.dart';
import 'package:shop_app/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 17, top: 20),
          child: Column(
            children: [
              Container(
                height: 46,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Image.asset('assets/images/icon_apple_blue.png'),
                      const Spacer(),
                      const Text(
                        'حساب کاربری',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'shabnamBold',
                            color: ColorsApp.blue,
                            fontSize: 16),
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                'شاهین عبدالمالکی',
                style: TextStyle(fontFamily: 'shabnamBold', fontSize: 16),
              ),
              const SizedBox(
                height: 6,
              ),
              const Text('09216920590',
                  style: TextStyle(
                      fontFamily: 'shabnam',
                      fontSize: 10,
                      color: ColorsApp.gray)),
             const Column(
                children: [
                  Padding(
                    padding:
                         EdgeInsets.only(left: 20, right: 20, top: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        // CategoryList(),
                        // CategoryList(),
                        // CategoryList(),
                        // CategoryList(),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                         EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        // CategoryList(),
                        // CategoryList(),
                        // CategoryList(),
                        // CategoryList(),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                         EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:  [
                        // CategoryList(),
                        SizedBox(
                          width: 10,
                        ),
                        // CategoryList(),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                'اپل شاپ',
                style: TextStyle(
                    fontFamily: 'shabnam', fontSize: 12, color: ColorsApp.gray),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text('V-1.00',
                    style: TextStyle(
                        fontFamily: 'shabnam',
                        fontSize: 12,
                        color: ColorsApp.gray)),
              ),
              const Text('instagram/_shahin_abdolmaleki',
                  style: TextStyle(
                      fontFamily: 'shabnam',
                      fontSize: 12,
                      color: ColorsApp.gray)),
            ],
          ),
        ),
      ),
    );
  }
}
