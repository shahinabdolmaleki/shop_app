import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/category_product/category_prodact_bloc.dart';
import 'package:shop_app/bloc/category_product/category_prodact_event.dart';
import 'package:shop_app/bloc/category_product/category_prodact_state.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/widgets/product_item.dart';

// ignore: must_be_immutable
class ProductScreen extends StatefulWidget {
  Category category;
  ProductScreen(this.category, {Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryProductBloc>(context)
        .add(Categoryprosuctinitialize(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductBloc, CategoryproductStat>(
        builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 17, top: 20),
                  child: Container(
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
                          Text(
                            widget.category.title!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'shabnamBold',
                                color: ColorsApp.blue,
                                fontSize: 16),
                          ),
                          const Spacer()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (state is CategoryLoadingState) ...{
                const SliverToBoxAdapter(
                  child: Center(
                      child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(),
                  )),
                )
              },
              if (state is CategoryRsponssuccesState) ...{
                state.response.fold((l) {
                  return SliverToBoxAdapter(
                    child: Text(l),
                  );
                }, (productList) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(((context, index) {
                        //   return ProductItem();
                        return ProductItem(productList[index]);
                      }), childCount: productList.length),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 2.6,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 10),
                    ),
                  );
                })
              }
            ],
          ),
        ),
      );
    });
  }
}
