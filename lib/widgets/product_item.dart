import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/basket/basket_bloc.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/data/model/product.dart';
import 'package:shop_app/di/di.dart';
import 'package:shop_app/screens/product_detailscreen.dart';
import 'package:shop_app/widgets/cached_image.dart';

// ignore: must_be_immutable
class ProductItem extends StatelessWidget {
  Product product;
  ProductItem(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BlocProvider<BasketBloc>.value(
                    value: locator.get<BasketBloc>(),
                    child: ProductDetailScreen(product),
                  )));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          width: 160,
          height: 216,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(),
                  SizedBox(
                    height: 98,
                    width: 98,
                    child: CachedImage(
                      imageUrl: product.thumbnail,
                    ),
                  ),
                  const Positioned(
                    top: 0,
                    right: 5,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: Image(
                          image: AssetImage(
                              'assets/images/active_fav_product.png')),
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    left: 10,
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      width: 25,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text('${product.persent!.round().toString()}%',
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'shabnam',
                              fontSize: 12)),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            fontFamily: 'shabnam', fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 53,
                    decoration: const BoxDecoration(
                        color: ColorsApp.blue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: ColorsApp.blue,
                              blurRadius: 25,
                              spreadRadius: -17,
                              offset: Offset(0.0, 12))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            'تومان',
                            style: TextStyle(
                                fontFamily: 'shabnam',
                                fontSize: 12,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(product.price.toString(),
                                  style: const TextStyle(
                                      fontFamily: 'shabnam',
                                      fontSize: 12,
                                      color: Colors.white,
                                      decoration: TextDecoration.lineThrough)),
                              Text(('${product.price + product.discountPrice}'),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'shabnam',
                                      fontSize: 16))
                            ],
                          ),
                          const Spacer(),
                          const SizedBox(
                            width: 24,
                            child: Image(
                                image: AssetImage(
                                    'assets/images/icon_right_arrow_cricle.png')),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
