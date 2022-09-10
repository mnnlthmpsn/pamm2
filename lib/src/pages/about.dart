import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        foregroundColor: KColors.kTextColorLight,
        backgroundColor: KColors.kPrimaryColor,
        title: const Text(
          'ABOUT',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }
}
