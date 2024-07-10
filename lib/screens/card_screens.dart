import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/bloc/basket/basket_bloc.dart';
import 'package:shop_app/bloc/basket/basket_state.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:shop_app/data/model/card_item.dart';

import 'package:shop_app/util/extentions/string_extentions.dart';
import 'package:shop_app/widgets/cached_image.dart';

import '../bloc/basket/basket_event.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.backGrounsScreencolor,
      body: SafeArea(child: BlocBuilder<BasketBloc, BasketStat>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomScrollView(
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
                                'سبد خرید',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'shabnamBold',
                                    color: ColorsApp.blue,
                                    fontSize: 16),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (state is Basketdatafetchstat) ...{
                    state.basketitemlist.fold(((l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    }), ((basketItemlist) {
                      return SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        return CardItem(basketItemlist[index]);
                      }, childCount: basketItemlist.length));
                    })),
                  },
                  const SliverPadding(padding: EdgeInsets.only(top: 50))
                ],
              ),
              if (state is Basketdatafetchstat) ...{
                SizedBox(
                  height: 53,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 3),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsApp.green,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onPressed: () async {
                        context.read<BasketBloc>().add(Basketpaymentinitevent());
                        context.read<BasketBloc>().add(Basketpaymentrequestinitevent());
                      },
                      child: Text(
                        (state.basketfinalprice == 0)
                            ? 'سبد خرید خالی است'
                            : state.basketfinalprice.toString(),
                        style: const TextStyle(
                            fontFamily: 'shabnamBold', fontSize: 16),
                      ),
                    ),
                  ),
                )
              }
            ],
          );
        },
      )),
    );
  }
}

// ignore: must_be_immutable
class CardItem extends StatelessWidget {
  BasketItem basketItem;
  CardItem(
    this.basketItem, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      height: 239,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(basketItem.name,
                            maxLines: 1,
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'shabnamBold',
                                fontSize: 16)),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('گارانتی 18 ماه مدیا پردازش',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: ColorsApp.gray,
                                fontFamily: 'shabnam',
                                fontSize: 12)),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 24,
                              child: Container(
                                alignment: AlignmentDirectional.center,
                                width: 25,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text('%${basketItem.persent}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'shabnam',
                                        fontSize: 10)),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text('تومان',
                                style: TextStyle(
                                    color: ColorsApp.gray,
                                    fontFamily: 'shabnamBold',
                                    fontSize: 12)),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(basketItem.price.toString(),
                                style: const TextStyle(
                                    color: ColorsApp.gray,
                                    fontFamily: 'shabnamBold',
                                    fontSize: 12)),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Wrap(
                          spacing: 5,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: ColorsApp.gray),
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    top: 2, bottom: 2, right: 10, left: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'حذف',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontFamily: 'shabnam', fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    SizedBox(
                                      width: 10,
                                      child: Image(
                                          image: AssetImage(
                                              'assets/images/icon_trash.png')),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            OptionWidget(
                              '256 گیگابایت',
                              color: '',
                            ),
                            OptionWidget('آبی', color: '4287f5'),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  SizedBox(
                    height: 104,
                    width: 100,
                    child: CachedImage(
                      imageUrl: basketItem.thumbnail,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: DottedLine(
                lineThickness: 3.0,
                dashLength: 8,
                dashColor: ColorsApp.gray.withOpacity(0.3),
                dashGapColor: Colors.transparent,
                dashGapLength: 3.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('تومان',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'shabnam',
                          fontSize: 15)),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(basketItem.realPrice.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'shabnam',
                          fontSize: 16)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class OptionWidget extends StatelessWidget {
  String? color;
  String title;
  OptionWidget(this.title, {Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: ColorsApp.gray),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.only(top: 2, bottom: 2, right: 10, left: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (color != null) ...{
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: color.parseToColor()),
              )
            },
            const SizedBox(
              width: 4,
            ),
            Text(
              title,
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontFamily: 'shabnam', fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
