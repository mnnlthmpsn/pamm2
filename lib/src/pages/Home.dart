import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/drawer.dart';
import 'package:pamm2/src/pages/Give.dart';
import 'package:pamm2/src/pages/drawer/contact.dart';
import 'package:pamm2/src/pages/eStore.dart';
import 'package:pamm2/src/pages/menuPage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const List menuItems = [
    {'title': 'Home', 'icon': Icons.home_rounded},
    {'title': 'Give', 'icon': Icons.favorite_rounded},
    {'title': 'eStore', 'icon': Icons.shopping_cart_rounded},
    {'title': 'More', 'icon': Icons.menu_rounded},
  ];

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeIndex = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  Widget iconBuilder(item, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: index == activeIndex ? 0 : 10.0),
            child: Icon(
              item['icon'],
              size: 30,
              color:
                  activeIndex == index ? Colors.white : KColors.kPrimaryColor,
            ),
          ),
          index == activeIndex
              ? const SizedBox.shrink()
              : Text(
                  item['title'],
                  style: TextStyle(
                      color: KColors.kPrimaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    List pages = [
      MenuPage(scaffoldKey: scaffoldKey),
      const Give(),
      const Store(),
      const Contact(src: 'home'),
    ];

    return Scaffold(
      key: scaffoldKey,
      extendBody: activeIndex == 0 ? true : false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: KColors.kPrimaryColor),
        automaticallyImplyLeading: false,
        toolbarHeight: activeIndex == 0 ? 0 : 56,
        backgroundColor:
            activeIndex == 0 ? Colors.transparent : KColors.kLightColor,
        elevation: 4,
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              activeIndex != 0 ? Home.menuItems[activeIndex]['title'] : '',
              style: TextStyle(fontSize: 16, color: KColors.kDarkColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: pages[activeIndex],
      drawer: const kDrawer(),
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  Widget _bottomNavigation() {
    return CurvedNavigationBar(
      onTap: (index) => setState(() => activeIndex = index),
      animationDuration: const Duration(milliseconds: 250),
      height: 60,
      animationCurve: Curves.easeInOut,
      backgroundColor: Colors.transparent,
      color: KColors.kLightColor,
      buttonBackgroundColor: KColors.kPrimaryColor,
      items: List.generate(
          4, (index) => iconBuilder(Home.menuItems[index], index)),
    );
  }
}
