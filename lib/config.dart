import 'package:flutter/material.dart';

class KColors {
  static Color kPrimaryColor2 = const Color(0xFFB12441);
  static Color kPrimaryColor = const Color(0xFFFF0000);
  static Color kDarkColor = const Color(0xFF222F3E);
  static Color kTextColorDark = const Color(0xFF1A1A1C);
  static Color kTextColorLight = const Color(0xFFD6D8DA);
  static Color kLightColor = const Color(0xFFEFEFEF);
}

class KTextTheme {
  static TextTheme textTheme = TextTheme(
      headline1: TextStyle(
          fontSize: 20.5,
          fontWeight: FontWeight.w700,
          color: KColors.kTextColorDark),
      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: KColors.kTextColorLight));
}

class InpBorder {
  static InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: KColors.kTextColorLight, width: 1));
}

class TextFieldTheme {
  static InputDecorationTheme textFieldTheme = InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      enabledBorder: InpBorder.inputBorder,
      focusedBorder: InpBorder.inputBorder,
      errorBorder: InpBorder.inputBorder
          .copyWith(borderSide: BorderSide(color: KColors.kPrimaryColor)));
}