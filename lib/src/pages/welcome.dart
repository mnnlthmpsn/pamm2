import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/helpers.dart';
import 'package:pamm2/src/components/kButton.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[_image(), _description(context)],
          ),
        ),
      ),
    );
  }

  void navigate(BuildContext context, String route) {
    newPageDestroyPrevious(context, route);
  }

  Widget _image() {
    return Expanded(
      flex: 2,
      child: Center(
        child: Image.asset('assets/images/pastor.png')
      ),
    );
  }

  Widget _description(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 5),
        Text('Welcome',
            style: TextStyle(color: KColors.kTextColorDark)),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(right: 60),
          child: Text('Millions of people use to turn their ideas into reality',
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(fontSize: 22, color: KColors.kDarkColor)),
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            KButton(
                label: 'Guest Login',
                color: KColors.kDarkColor,
                icon: Icons.person_add_alt_1_rounded,
                onPressed: () => navigate(context, 'home')),
            KButton(
                label: 'Next',
                color: KColors.kPrimaryColor,
                onPressed: () => navigate(context, 'login')),
          ],
        )
      ],
    ));
  }
}
