import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/helpers.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final Duration _duration = Duration(milliseconds: 600);
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
        currentPage != 2 ? currentPage = currentPage + 1 : currentPage = 0);
  }

  List<String> images = [
    'assets/images/2.jpg',
    'assets/images/1.jpg',
    'assets/images/3.jpg',
  ];

  List menus = [
    [
      {'title': 'PAMM TV', 'icon': Icons.tv_rounded, 'route': 'tv'},
      {'title': 'iRadio', 'icon': Icons.radio_rounded, 'route': 'radio'},
      {
        'title': 'Partner',
        'icon': Icons.person_add_alt_1_rounded,
        'route': 'partner'
      }
    ],
    [
      {'title': 'Bible', 'icon': Icons.menu_book_rounded, 'route': 'bible'},
      {'title': 'PAMA', 'icon': Icons.group_add_rounded, 'route': 'pama'},
      {
        'title': 'Archives',
        'icon': Icons.play_arrow_rounded,
        'route': 'archives'
      }
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _bg(),
          Positioned(
              right: 0,
              left: 0,
              bottom: MediaQuery.of(context).size.height * .12,
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                  child: _menuItems())),
          Positioned(
            top: 20,
            left: 10,
            child: SizedBox(
              height: 50, width: 50,
              child: Image.asset('assets/images/logo.png'),
            ),
          )
        ],
      ),
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
          )
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
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(menus[parentIndex][index]['icon']),
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
    return AnimatedSwitcher(
      duration: _duration,
      child: SizedBox(key: ValueKey<int>(currentPage), child: pageBuilder()),
    );
  }

  Widget pageBuilder() {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: KColors.kPrimaryColor,
            image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                image: AssetImage(images[currentPage]),
                colorFilter: ColorFilter.mode(
                    KColors.kPrimaryColor.withOpacity(.7), BlendMode.dstATop)),
          ),
        );
      },
    );
  }
}
