import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/category_product/category_prodact_bloc.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/screens/product_lists_screen.dart';
import 'package:shop_app/widgets/cached_image.dart';

// ignore: must_be_immutable
class CategoryHorizontalItemList extends StatelessWidget {
  List<Category> listcategories;
  CategoryHorizontalItemList(
    this.listcategories, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.backGrounsScreencolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
            reverse: true,
            itemCount: listcategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoryList(listcategories[index]);
            }),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final Category category;
  const CategoryList(
    this.category, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String categorycolor = 'ff${category.color}';
    int hexcolor = int.parse(categorycolor, radix: 16);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CategoryProductBloc(),
                  child: ProductScreen(category),
                )));
      },
      child: Column(
        children: [
          Center(
              child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: ShapeDecoration(
                      color: Color(hexcolor),
                      shadows: [
                        BoxShadow(
                            color: Color(hexcolor),
                            blurRadius: 20,
                            spreadRadius: -12,
                            offset:const Offset(0.0, 7))
                      ],
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                ),
              ),
              SizedBox(
                height: 24,
                width: 24,
                child: Center(
                  child: CachedImage(
                    imageUrl: category.icon,
                  ),
                ),
              )
            ],
          )),
          const SizedBox(
            height: 10,
          ),
          Text(
            category.title ?? 'محصول',
            style:const TextStyle(fontFamily: 'shabnamBold', fontSize: 12),
          )
        ],
      ),
    );
  }
}
