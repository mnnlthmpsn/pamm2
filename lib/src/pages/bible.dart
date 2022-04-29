import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/webViewBuilder.dart';

class Bible extends StatelessWidget {
  const Bible({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: const WebViewBuilder(url: 'https://www.bible.com/en-GB/bible/116/GEN.1.NLT'),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: KColors.kPrimaryColor,
      title: const Text('Bible', style: TextStyle(fontSize: 18))
    );
  }
}
