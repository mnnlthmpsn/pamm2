import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/drawer.dart';

class IRadio extends StatefulWidget {
  const IRadio({Key? key}) : super(key: key);

  @override
  State<IRadio> createState() => _IRadioState();
}

class _IRadioState extends State<IRadio> {
  int currentMenu = 0;

  List<String> menus = ['Now Playing', 'Schedule'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      drawer: kDrawer(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      foregroundColor: KColors.kPrimaryColor,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_rounded)),
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset('assets/images/logo.png'),
          ),
          openDrawer()
        ],
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Column(
      children: [_headerNav(), Expanded(child: _radioBody())],
    );
  }

  Widget _headerNav() {
    return Builder(
      builder: (BuildContext context) {
        return Row(
          children: List.generate(2, (index) => _menuBuilder(index)),
        );
      },
    );
  }

  Widget _menuBuilder(int index) {
    return GestureDetector(
      onTap: () => setState(() => currentMenu = index),
      child: Container(
        width: MediaQuery.of(context).size.width * .5,
        height: MediaQuery.of(context).size.height * .07,
        color:
            index == currentMenu ? KColors.kPrimaryColor : KColors.kLightColor,
        child: Center(
            child: Text(menus[index],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: index == currentMenu
                        ? Colors.white
                        : KColors.kDarkColor))),
      ),
    );
  }

  Widget _radioBody() {
    return currentMenu == 0 ? _nowPlaying() : _schedule();
  }

  Widget _nowPlaying() {
    return Center(
      child: CircularProgressIndicator(
        color: KColors.kPrimaryColor,
      ),
    );
  }

  Widget _schedule() {
    return Text('Schedule');
  }
}
