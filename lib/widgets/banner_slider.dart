import 'package:flutter/material.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/data/model/banner.dart';
import 'package:shop_app/widgets/cached_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class BannerSlider extends StatelessWidget {
  List<BannerApp> bannerList;
  BannerSlider(
    this.bannerList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = PageController(viewportFraction: 0.9);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: 177,
          child: PageView.builder(
            reverse: true,
            controller: controller,
            itemCount: bannerList.length,
            itemBuilder: (context, index) {
              return Container(
                margin:const  EdgeInsets.all(6),
                child: CachedImage(
                  imageUrl: bannerList[index].thumbnail,
                  radius: 15,
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 10,
          child: SmoothPageIndicator(
            controller: controller,
            count: 3,
            textDirection: TextDirection.rtl,
            effect: const ExpandingDotsEffect(
                expansionFactor: 3,
                dotHeight: 6,
                dotWidth: 6,
                dotColor: Colors.white,
                activeDotColor: ColorsApp.blueindicator),
          ),
        ),
      ],
    );
  }
}
