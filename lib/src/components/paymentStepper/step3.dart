import 'package:flutter/material.dart';
import 'package:pamm2/src/components/kButton.dart';
import 'package:pamm2/src/components/kFormField.dart';

class Step3 extends StatelessWidget {
  final int active;

  const Step3({Key? key, required this.active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return active == 0 ? _momo() : _card();
  }

  Widget _momo() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 30,
        ),
        const KFormField(label: 'Network', icon: Icons.sim_card),
        const SizedBox(height: 50),
        KButton(
          label: 'Pay GHS 50.00',
          icon: Icons.lock_rounded,
          color: Colors.green,
          onPressed: () {},
        )
      ],
    );
  }

  Widget _card() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 30,
        ),
        const KFormField(
          label: 'Card Number',
          icon: Icons.credit_card,
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: const <Widget>[
            Expanded(
                child: KFormField(
              label: 'MM/YY',
              icon: Icons.calendar_today_rounded,
            )),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: KFormField(
              label: 'CVV',
              icon: Icons.pin_rounded,
            )),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: const <Widget>[
            Expanded(
                child: KFormField(
              label: 'Post code',
              icon: Icons.location_on_rounded,
            )),
            SizedBox(
              width: 8,
            ),
            Expanded(child: SizedBox.shrink()),
          ],
        ),
        const SizedBox(height: 50),
        KButton(
          onPressed: () {},
          label: 'Pay GHS 50.00',
          icon: Icons.lock_rounded,
          color: Colors.green,
        )
      ],
    );
  }
}
