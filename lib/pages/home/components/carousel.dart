import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/constants.dart';
import '../../../utils/screen_helper.dart';
import 'carousel_items.dart';

class Carousel extends StatelessWidget {
  final CarouselController carouselController = CarouselController();

  Carousel({Key? key}) : super(key: key);

  Widget _buildDesktop(BuildContext context, Widget text, Widget image) {
    return Center(
      child: ResponsiveWrapper(
        maxWidth: kDesktopMaxWidth,
        minWidth: kDesktopMaxWidth,
        child: Row(
          children: [
            Expanded(
              child: text,
            ),
            Expanded(
              child: image,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTablet(BuildContext context, Widget text, Widget image) {
    return Center(
      child: ResponsiveWrapper(
        maxWidth: kTabletMaxWidth,
        minWidth: kTabletMaxWidth,
        child: Row(
          children: [
            Expanded(
              child: text,
            ),
            Expanded(
              child: image,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMobile(BuildContext context, Widget text, Widget image) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: getMobileMaxWidth(context),
      ),
      width: double.infinity,
      child: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    double carouselContainerHeight = MediaQuery.of(context).size.height *
        (ScreenHelper.isMobile(context) ? 0.7 : 0.85);
    return SizedBox(
      height: carouselContainerHeight,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                viewportFraction: 1,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                height: carouselContainerHeight,
              ),
              items: List.generate(
                carouselItems.length,
                (index) => Builder(builder: (context) {
                  return Container(
                    constraints: BoxConstraints(
                      minHeight: carouselContainerHeight,
                    ),
                    child: ScreenHelper(
                      desktop: _buildDesktop(
                        context,
                        carouselItems[index].text,
                        carouselItems[index].image,
                      ),
                      tablet: _buildTablet(
                        context,
                        carouselItems[index].text,
                        carouselItems[index].image,
                      ),
                      mobile: _buildMobile(
                        context,
                        carouselItems[index].text,
                        carouselItems[index].image,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
