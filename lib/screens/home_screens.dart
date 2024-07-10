import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/home/home_event.dart';
import 'package:shop_app/bloc/home/home_bloc.dart';
import 'package:shop_app/bloc/home/home_state.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/data/model/banner.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/data/model/product.dart';

import 'package:shop_app/widgets/banner_slider.dart';
import 'package:shop_app/widgets/category_horizontalitem.dart';
import 'package:shop_app/widgets/product_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeGetInitializedData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.backGrounsScreencolor,
      body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return CustomScrollView(
          slivers: [
            const _TitleHomeScreen(),
            if (state is HomeLoadingState) ...{
              const SliverToBoxAdapter(
                child: Center(
                  child: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator()),
                ),
              )
            } else ...{
              if (state is HomeRequestSuccesState) ...[
                state.bannerList.fold((l) {
                  return SliverToBoxAdapter(
                    child: Text(l),
                  );
                }, (r) {
                  return _BannerHomeScreen(r);
                })
              ],
              const _TitleCategory(),
              if (state is HomeRequestSuccesState) ...[
                state.categoryList.fold((l) {
                  return SliverToBoxAdapter(
                    child: Text(l),
                  );
                }, (categoryListrespons) {
                  return CategoryHorizontal(categoryListrespons);
                })
              ],
              const SliverToBoxAdapter(
                child: Padding(
                  padding:
                       EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children:  [
                      Image(
                        image:
                            AssetImage('assets/images/icon_left_categroy.png'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'مشاهده همه',
                        style: TextStyle(
                            fontFamily: 'shabnamBold',
                            fontSize: 12,
                            color: ColorsApp.blue),
                      ),
                      Spacer(),
                      Text(
                        'پرفروش ترین ها',
                        style: TextStyle(
                            fontFamily: 'shabnamBold',
                            fontSize: 12,
                            color: ColorsApp.gray),
                      ),
                    ],
                  ),
                ),
              ),
              if (state is HomeRequestSuccesState) ...[
                state.bestsellerproductList.fold((l) {
                  return SliverToBoxAdapter(
                    child: Text(l),
                  );
                }, (productListr) {
                  return _ProductItem(productListr);
                })
              ],
             const SliverToBoxAdapter(
                child: Padding(
                  padding:
                       EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children:  [
                      Image(
                        image:
                            AssetImage('assets/images/icon_left_categroy.png'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'مشاهده همه',
                        style: TextStyle(
                            fontFamily: 'shabnamBold',
                            fontSize: 12,
                            color: ColorsApp.blue),
                      ),
                      Spacer(),
                      Text(
                        'پربازدیدترین ها',
                        style: TextStyle(
                            fontFamily: 'shabnamBold',
                            fontSize: 12,
                            color: ColorsApp.gray),
                      ),
                    ],
                  ),
                ),
              ),
              if (state is HomeRequestSuccesState) ...[
                state.hottestproductList.fold((l) {
                  return SliverToBoxAdapter(
                    child: Text(l),
                  );
                }, (productListr2) {
                  return _Getmostviewedproduct(productListr2);
                })
              ],
            },
          ],
        );
      })),
    );
  }
}

// ignore: must_be_immutable
class _Getmostviewedproduct extends StatelessWidget {
  List<Product> hotestproductlist;
  _Getmostviewedproduct(
    this.hotestproductlist, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hotestproductlist.length,
            reverse: true,
            itemBuilder: ((context, index) {
              return ProductItem(hotestproductlist[index]);
            })),
      ),
    );
  }
}

// ignore: must_be_immutable
class _ProductItem extends StatelessWidget {
  List<Product> productlist;
  _ProductItem(
    this.productlist, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productlist.length,
        reverse: true,
        itemBuilder: ((context, index) {
          return ProductItem(productlist[index]);
        }),
      ),
    ));
  }
}

// ignore: must_be_immutable
class CategoryHorizontal extends StatelessWidget {
  List<Category> listcategories;
  CategoryHorizontal(
    this.listcategories, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 102,
        child: CategoryHorizontalItemList(listcategories),
      ),
    );
  }
}

class _TitleCategory extends StatelessWidget {
  const _TitleCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(right: 20),
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: 32, bottom: 20),
            child: Text(
              'دسته بندی',
              style: TextStyle(
                  fontFamily: 'shabnamBold',
                  fontSize: 12,
                  color: ColorsApp.gray),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _BannerHomeScreen extends StatelessWidget {
  List<BannerApp> bannerList;
  _BannerHomeScreen(
    this.bannerList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BannerSlider(bannerList),
    );
  }
}

class _TitleHomeScreen extends StatelessWidget {
  const _TitleHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 17, top: 20),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Image.asset('assets/images/icon_apple_blue.png'),
                const Spacer(),
                const Text(
                  'جستجوی محصولات',
                  style: TextStyle(
                      fontFamily: 'shabnamBold',
                      color: ColorsApp.gray,
                      fontSize: 16),
                ),
                const SizedBox(
                  width: 16,
                ),
                Image.asset('assets/images/icon_search.png')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
