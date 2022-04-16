import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/drawer.dart';
import 'package:pamm2/src/pages/Give.dart';

class GiveAnnex extends Give {
  const GiveAnnex({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget appBar() {
    // TODO: implement appBar
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: KColors.kPrimaryColor,
      elevation: 0,
      title: Builder(
        builder: (BuildContext context) {
          return const Text('Give', style: TextStyle(fontSize: 18),);
        },
      ),
    );
  }
}
