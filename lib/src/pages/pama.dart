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
      drawer: const kDrawer(),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: KColors.kPrimaryColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_rounded)),
          const Text(
            'PAMA',
              style: TextStyle(fontSize: 18)
          ),
          openDrawer()
        ],
      ),
    );
  }
}
