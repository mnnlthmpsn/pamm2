import 'dart:async';
import 'package:faded_widget/faded_widget.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/generated/assets.dart';
import 'package:pamm2/src/pages/Home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5),
        () => {Navigator.of(context).pushReplacementNamed('home')});

    return SafeArea(
      child: FadedWidget(
        height: 400,
        width: 400,
        direction: GradientDirection.ttb,
        fade: [
          KColors.kPrimaryColor,
          Colors.yellow,
          Colors.orange,
        ],
        child: Container(
          color: Colors.redAccent,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                child: Image(
                  image: AssetImage(Assets.images2),
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                color: KColors.kPrimaryColor.withOpacity(.65),
                height: double.infinity,
                child: Center(
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Image.asset(Assets.imagesLogo, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
