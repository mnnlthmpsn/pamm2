import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';

class KButton extends StatelessWidget {

  final IconData? icon;
  final String? label;
  final Color? color;
  final VoidCallback onPressed;

  const KButton({Key? key, this.icon, this.label, this.color, required this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
          style:
          ElevatedButton.styleFrom(primary: color ?? KColors.kDarkColor),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(label ?? 'Next'), const SizedBox(width: 10,), Icon(icon ?? Icons.arrow_forward_rounded)],
          )),
    );
  }
}
