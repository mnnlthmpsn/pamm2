import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';

class KFormField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool? textarea;
  final Color? enabledBorder;
  final TextEditingController controller;

  const KFormField(
      {Key? key,
      required this.label,
      this.icon,
      this.textarea,
      required this.controller,
      this.enabledBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: KColors.kTextColorDark,
      maxLines: textarea != null ? 3 : 1,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: label,
          labelStyle: TextStyle(fontSize: 14, color: KColors.kTextColorDark),
          enabledBorder: textBorder(),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: KColors.kPrimaryColor))),
    );
  }

  InputBorder textBorder() {
    return UnderlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey.withOpacity(.5)));
  }
}
