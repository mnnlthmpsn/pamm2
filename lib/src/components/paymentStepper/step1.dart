import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/kButton.dart';

class Step1 extends StatefulWidget {
  final updateIndex;

  const Step1({Key? key, required this.updateIndex}) : super(key: key);

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  @override
  Widget build(BuildContext context) {
    return _parent(context);
  }

  Widget _parent(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.euro,
                  color: KColors.kDarkColor.withOpacity(.5),
                  size: 15,
                ),
              ),
              cursorColor: KColors.kTextColorDark,
              cursorWidth: 1,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: KColors.kTextColorDark.withOpacity(.8), fontSize: 22),
            ),
            const SizedBox(
              height: 50,
            ),
            KButton(onPressed: widget.updateIndex),
            const SizedBox(height: 20),
            Text(
              'PAMA Ministries',
              style: TextStyle(fontSize: 10, color: KColors.kPrimaryColor),
            )
          ],
        ),
      ),
    );
  }
}
