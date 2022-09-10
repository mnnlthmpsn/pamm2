import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/drawer.dart';
import 'package:pamm2/src/controllers/cart_controllelr.dart';
import 'package:pamm2/src/pages/drawer/contact.dart';
import 'package:pamm2/src/pages/drawer/prayer.dart';
import 'package:pamm2/src/pages/events.dart';
import 'package:pamm2/src/pages/menuPage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const List menuItems = [
    {'title': 'Home', 'icon': FontAwesomeIcons.house, 'type': 'icon'},
    {'title': 'Prayer', 'icon': 'assets/icons/pray_noline.png', 'type': 'image'},
    {'title': 'Events', 'icon': 'assets/icons/event_large.png', 'type': 'image'},
    {'title': 'Contact', 'icon': 'assets/icons/call_us_large.png', 'type': 'image'},
  ];

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeIndex = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  CartController cartController = Get.put(CartController());


  Widget iconBuilder(item, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: index == activeIndex ? 0 : 18.0, bottom: 2),
            child: item['type'] == 'icon'
              ? FaIcon(item['icon'], size: 21.5, color: activeIndex == index ? Colors.white : Colors.black87.withOpacity(.8))
              : Image.asset(item['icon'], color: activeIndex == index ? Colors.white : Colors.black87.withOpacity(.8), height: 22.5),
          ),
          index == activeIndex
              ? const SizedBox.shrink()
              : Text(
                  item['title'].toString().toUpperCase(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w900),
                )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      MenuPage(scaffoldKey: scaffoldKey),
      const Prayer(src: 'home'),
      const Events(src: 'home'),
      const Contact(src: 'home'),
    ];

    return Scaffold(
      key: scaffoldKey,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: KColors.kPrimaryColor),
        automaticallyImplyLeading: false,
        toolbarHeight: activeIndex == 0 ? 0 : 56,
        backgroundColor:
            activeIndex == 0 ? Colors.transparent : KColors.kPrimaryColor,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              activeIndex != 0 ? Home.menuItems[activeIndex]['title'].toString().toUpperCase() : '',
              style: TextStyle(
                  fontSize: 16,
                  color: KColors.kLightColor,
                  fontWeight: FontWeight.bold),
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
