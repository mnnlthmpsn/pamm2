import 'package:flutter/material.dart';
import 'package:pamm2/src/components/drawer.dart';
import 'package:pamm2/src/components/paymentStepper/paymentStepper.dart';
import 'package:pamm2/src/components/webViewBuilder.dart';

class Give extends StatelessWidget {
  const Give({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: const WebViewBuilder(url: 'https://pama.vercel.app/give')
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      toolbarHeight: 0,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}
