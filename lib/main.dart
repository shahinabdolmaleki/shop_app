import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shop_app/bloc/basket/basket_event.dart';
import 'package:shop_app/bloc/category/category_bloc.dart';
import 'package:shop_app/bloc/home/home_bloc.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/data/model/card_item.dart';
import 'package:shop_app/di/di.dart';
import 'package:shop_app/screens/card_screens.dart';
import 'package:shop_app/screens/category_screen.dart';
import 'package:shop_app/screens/home_screens.dart';

import 'package:shop_app/screens/profile_screen.dart';

import 'bloc/basket/basket_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  await Hive.openBox<BasketItem>('CardBox');

  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedbottomnavigation = 3;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IndexedStack(
            index: selectedbottomnavigation, children: getscreens()),
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: BottomNavigationBar(
              onTap: (int index) {
                setState(() {
                  selectedbottomnavigation = index;
                });
              },
              elevation: 0,
              selectedLabelStyle: const TextStyle(
                  fontFamily: 'shabnamBold',
                  fontSize: 12,
                  color: ColorsApp.blue),
              unselectedLabelStyle: const TextStyle(
                  fontFamily: 'shabnamBold', fontSize: 12, color: Colors.black),
              backgroundColor: Colors.transparent,
              currentIndex: selectedbottomnavigation,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  label: 'حساب کاربری',
                  icon: Image.asset('assets/images/icon_profile.png'),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Container(
                      child:
                          Image.asset('assets/images/icon_profile_active.png'),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: ColorsApp.blue,
                              blurRadius: 20,
                              spreadRadius: -7,
                              offset: Offset(0.0, 13))
                        ],
                      ),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                    label: 'سبد خرید',
                    icon: Image.asset('assets/images/icon_basket.png'),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Container(
                        child:
                            Image.asset('assets/images/icon_basket_active.png'),
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: ColorsApp.blue,
                              blurRadius: 20,
                              spreadRadius: -7,
                              offset: Offset(0.0, 13))
                        ]),
                      ),
                    )),
                BottomNavigationBarItem(
                    label: 'دسته بندی',
                    icon: Image.asset('assets/images/icon_category.png'),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Container(
                        child: Image.asset(
                            'assets/images/icon_category_active.png'),
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: ColorsApp.blue,
                              blurRadius: 20,
                              spreadRadius: -7,
                              offset: Offset(0.0, 13))
                        ]),
                      ),
                    )),
                BottomNavigationBarItem(
                  label: 'خانه',
                  icon: Image.asset('assets/images/icon_home.png'),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Container(
                      child: Image.asset('assets/images/icon_home_active.png'),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: ColorsApp.blue,
                              blurRadius: 20,
                              spreadRadius: -7,
                              offset: Offset(0.0, 13))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//main page widget for show all page
  List<Widget> getscreens() {
    return <Widget>[
      const ProfileScreen(),
      BlocProvider(
        create: ((context) {
          var bloc = locator.get<BasketBloc>();
          bloc.add(BasketfetchfromHiveevent());
          return bloc;
        }),
        child: const CardScreen(),
      ),
      BlocProvider(
        create: (context) => CategoryBloc(),
        child: const CategoryScreen(),
      ),
      BlocProvider(
        create: (context) => HomeBloc(),
        child: const HomeScreen(),
      ),
    ];
  }
}
