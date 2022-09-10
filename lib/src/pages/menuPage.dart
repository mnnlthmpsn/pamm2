import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/helpers.dart';
import 'package:pamm2/src/components/drawer.dart';

class MenuPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MenuPage({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final Duration _duration = const Duration(milliseconds: 600);
  int currentPage = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 5), (Timer t) => updatePage());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void updatePage() {
    // do request here
    setState(() =>
        currentPage != 4 ? currentPage = currentPage + 1 : currentPage = 0);
  }

  List<String> images = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
  ];

  List menus = [
    [
      {
        'title': 'CAM TV',
        'icon': Image.asset(
          'assets/icons/tv.png',
          width: 35,
          height: 35,
        ),
        'route': 'tv',
        'image': true
      },
      {
        'title': 'iRadio',
        'icon': Image.asset(
          'assets/icons/radio.png',
          width: 35,
          height: 35,
        ),
        'route': 'radio',
        'image': true
      },
      {
        'title': 'Partner',
        'icon': Image.asset(
          'assets/icons/partner.png',
          width: 35,
          height: 35,
        ),
        'route': 'partner',
        'image': true
      }
    ],
    [
      {
        'title': 'Give',
        'icon': Image.asset(
          'assets/icons/give 2.png',
          width: 35,
          height: 35,
        ),
        'route': 'give_2',
        'image': true
      },
      {
        'title': 'eStore',
        'icon': Icons.shopping_cart_rounded,
        'route': 'store_2',
        'image': false
      },
      {
        'title': 'Bible',
        'icon': Icons.menu_book_rounded,
        'route': 'bible',
        'image': false
      }
    ],
    [
      {
        'title': 'CAMA',
        'icon': Icons.group_add_rounded,
        'route': 'pama',
        'image': false
      },
      {
        'title': 'Archives',
        'icon': Image.asset(
          'assets/icons/archives.png',
          width: 30,
          height: 30,
        ),
        'route': 'archives',
        'image': true
      },
      {
        'title': 'Social',
        'icon': Image.asset(
          'assets/icons/all_social.png',
          width: 35,
          height: 35,
        ),
        'route': 'social',
        'image': true
      }
    ],
    // [
    //   {
    //     'title': 'Prayer',
    //     'icon': const FaIcon(FontAwesomeIcons.handsPraying),
    //     'route': 'prayer',
    //     'image': true
    //   },
    //   {
    //     'title': 'Events',
    //     'icon': Icons.calendar_today_rounded,
    //     'route': 'events_2',
    //     'image': false
    //   },
    //   {
    //     'title': 'Contact',
    //     'icon': Icons.mail_rounded,
    //     'route': 'contact',
    //     'image': false
    //   }
    // ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/logo.png', height: 40,),
              IconButton(
                color: KColors.kDarkColor,
                icon: const Icon(
                  Icons.menu,
                  size: 30,
                ),
                onPressed: () {
                  widget.scaffoldKey.currentState!.openDrawer();
                },
              )
            ],
          )),
      backgroundColor: KColors.kLightColor,
      body: Stack(
        children: [
          _bg(),
          Positioned(
              right: 0,
              left: 0,
              bottom: MediaQuery.of(context).size.height * .12,
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * .45,
                  child: _menuItems())),
        ],
      ),
      drawer: const kDrawer(),
    );
  }

  Widget _menuItems() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) => _menuCard(0, index))),
          ),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) => _menuCard(1, index))),
          ),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) => _menuCard(2, index))),
          ),
          // Expanded(
          //   child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: List.generate(3, (index) => _menuCard(3, index))),
          // )
        ],
      ),
    );
  }

  Widget _menuCard(int parentIndex, int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                onPrimary: KColors.kPrimaryColor,
                primary: KColors.kLightColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                menus[parentIndex][index]['image'] == true
                    ? menus[parentIndex][index]['icon']
                    : Icon(
                        menus[parentIndex][index]['icon'],
                        color: KColors.kPrimaryColor,
                        size: 35,
                      ),
                Text(
                  menus[parentIndex][index]['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: KColors.kDarkColor),
                )
              ],
            ),
            onPressed: () =>
                newPage(context, menus[parentIndex][index]['route']),
          ),
        ),
      ),
    );
  }

  Widget _bg() {
    return Container(
      padding: const EdgeInsets.only(top: 25),
      color: KColors.kLightColor,
      child: AnimatedSwitcher(
        duration: _duration,
        child: SizedBox(key: ValueKey<int>(currentPage), child: pageBuilder()),
      ),
    );
  }

  Widget pageBuilder() {
    return Builder(
      builder: (BuildContext context) {
        return Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .02,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                images[currentPage],
                fit: BoxFit.cover,
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   height: double.infinity,
            //   color: KColors.kPrimaryColor.withOpacity(.2),
            // ),
          ],
        );
      },
    );
  }
}
