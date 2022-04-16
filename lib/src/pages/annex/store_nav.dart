import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/drawer.dart';
import 'package:pamm2/src/pages/eStore.dart';

class StoreAnnex extends Store {
  const StoreAnnex({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: KColors.kPrimaryColor,
      elevation: 0,
      title: Builder(
        builder: (BuildContext context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded)),
              const Text(
                'eStore',
                style: TextStyle(fontSize: 16),
              ),
            ],
          );
        },
      ),
    );
  }
}