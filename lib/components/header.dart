import 'package:devhouse_website_flutter/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../models/header_item.dart';
import '../utils/constants.dart';
import '../utils/globals.dart';
import 'mouse_region.dart';
import 'responsive.dart';

final List<HeaderItem> headerItems = [
  HeaderItem(
    title: 'HOME',
    onTap: () {},
  ),
  HeaderItem(
    title: 'MY INTRO',
    onTap: () {},
  ),
  HeaderItem(
    title: 'SERVICES',
    onTap: () {},
  ),
  HeaderItem(
    title: 'PORTFOLIO',
    onTap: () {},
  ),
  HeaderItem(
    title: 'TESTIMONIALS',
    onTap: () {},
  ),
  HeaderItem(
    title: 'BLOG',
    onTap: () {},
  ),
  HeaderItem(
    title: 'HIRE ME',
    isButton: true,
    onTap: () {},
  ),
];

class MobileMenu extends StatelessWidget {
  const MobileMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: ListView.separated(
            itemBuilder: (context, index) {
              if (headerItems[index].isButton) {
                return DHMouseRegion(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    decoration: BoxDecoration(
                      color: kDangerColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: headerItems[index].onTap,
                      child: Text(
                        headerItems[index].title,
                        style: Typo.defaltWhite13Bold,
                      ),
                    ),
                  ),
                );
              } else {
                return ListTile(
                  title: Text(
                    headerItems[index].title,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemCount: headerItems.length,
          ),
        ),
      ),
    );
  }
}

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DHMouseRegion(
      child: GestureDetector(
        onTap: () {},
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'DevHouse', style: Typo.gOswaldWhite32Bold),
              TextSpan(text: '.', style: Typo.defaltPrimary36Bold),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  const HeaderRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveVisibility(
      visible: false,
      visibleWhen: const [
        Condition.largerThan(name: MOBILE),
      ],
      child: Row(
        children: headerItems.map((item) {
          if (item.isButton) {
            return DHMouseRegion(
              child: Container(
                decoration: BoxDecoration(
                  color: kDangerColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: TextButton(
                  onPressed: item.onTap,
                  child: Text(item.title, style: Typo.defaltWhite13Bold),
                ),
              ),
            );
          } else {
            return DHMouseRegion(
              child: Container(
                margin: const EdgeInsets.only(right: 30),
                child: GestureDetector(
                  onTap: item.onTap,
                  child: Text(item.title, style: Typo.defaltWhite13Bold),
                ),
              ),
            );
          }
        }).toList(),
      ),
    );
  }
}

class Header extends Responsive {
  const Header({Key? key}) : super(key: key);

  Widget _mobileMenuIcon() {
    return GestureDetector(
      onTap: () {
        Globals.scaffoldKey.currentState?.openEndDrawer();
      },
      child: const Icon(
        Icons.menu,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  @override
  Widget buildUi(BuildContext context, double width) {
    final mobile = isMobile(context);

    Widget header = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HeaderLogo(),
          mobile ? _mobileMenuIcon() : const HeaderRow(),
        ],
      ),
    );
    if (mobile) {
      header = SafeArea(child: header);
    }
    return header;
  }
}