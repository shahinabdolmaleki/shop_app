import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/category/category_bloc.dart';
import 'package:shop_app/bloc/category/category_event.dart';
import 'package:shop_app/bloc/category/category_state.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/widgets/cached_image.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequestList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        const Text(
                          'دسته بندی',
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
              ),
            ),
            BlocBuilder<CategoryBloc, CategoryStat>(builder: (context, state) {
              if (state is CategoryLoadingState) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator()),
                  ),
                );
              }
              if (state is CategoryRsponsState) {
                return state.response.fold((l) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text(l)),
                  );
                }, (r) {
                  return _ListCategory(list: r);
                });
              }
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text('error'),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _ListCategory extends StatelessWidget {
  List<Category>? list;
  _ListCategory({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(((context, index) {
          return CachedImage(imageUrl: list?[index].thumbnail);
        }), childCount: list?.length ?? 0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
      ),
    );
  }
}
