import 'package:flutter/material.dart';
import 'package:pamm2/src/components/drawer.dart';
import 'package:pamm2/src/components/paymentStepper/paymentStepper.dart';

class Give extends StatelessWidget {
  const Give({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: const Padding(
        padding: EdgeInsets.only(bottom: 30, left: 10, right: 10),
        child: PaymentStepper(),
      ),
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
