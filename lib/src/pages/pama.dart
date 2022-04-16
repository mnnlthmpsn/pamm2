import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/drawer.dart';
import 'package:pamm2/src/components/webViewBuilder.dart';

class PAMA extends StatelessWidget {
  const PAMA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: const SafeArea(
          child: WebViewBuilder(url: 'https://pama.vercel.app/pama')),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: KColors.kPrimaryColor,
      title: const Text(
          'PAMA',
          style: TextStyle(fontSize: 18)
      ),
    );
  }
}
