import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';

class KFormField extends StatelessWidget {
  final String label;
  final IconData icon;

  const KFormField({Key? key, required this.label, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: KColors.kTextColorDark,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: label,
          labelStyle: TextStyle(fontSize: 14, color: KColors.kTextColorDark),
          prefixIcon: Icon(
            icon,
            size: 20,
            color: Colors.grey.withOpacity(.5),
          ),
          enabledBorder: textBorder(),
          focusedBorder: textBorder()),
    );
  }

  InputBorder textBorder() {
    return UnderlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey.withOpacity(.5)));
  }
}
