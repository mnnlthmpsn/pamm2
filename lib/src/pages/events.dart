import 'package:flutter/material.dart';
import 'package:pamm2/src/components/drawer.dart';

class Events extends StatelessWidget {
  const Events({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: const Center(
        child: Text('Events here'),
      ),
      drawer: const kDrawer(),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      toolbarHeight: 0,
      backgroundColor: Colors.transparent,
    );
  }
}
