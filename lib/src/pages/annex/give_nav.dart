import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/pages/Give.dart';

class GiveAnnex extends Give {
  const GiveAnnex({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget appBar() {
    // TODO: implement appBar
    return AppBar(
        elevation: 0,
        systemOverlayStyle:
        SystemUiOverlayStyle(statusBarColor: KColors.kPrimaryColor),
        automaticallyImplyLeading: true,
        foregroundColor: KColors.kLightColor,
        backgroundColor: KColors.kPrimaryColor,
        title: Text('Give'));
  }
}
