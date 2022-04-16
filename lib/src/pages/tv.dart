import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/drawer.dart';

class TV extends StatelessWidget {
  const TV({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: const Center(
        child: Text('TV'),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: KColors.kPrimaryColor,
      title: const Text('PAMM TV', style: TextStyle(fontSize: 18))
    );
  }
}
