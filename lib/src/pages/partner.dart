import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/webViewBuilder.dart';

class Partner extends StatelessWidget {
  const Partner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: const WebViewBuilder(url: 'https://pama.vercel.app/partner'),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: KColors.kPrimaryColor,
        title: const Text('Partner', style: TextStyle(fontSize: 18)));
  }
}
