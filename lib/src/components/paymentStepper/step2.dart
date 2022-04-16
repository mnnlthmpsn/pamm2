import 'package:flutter/material.dart';
import 'package:pamm2/src/components/kButton.dart';
import 'package:pamm2/src/components/kFormField.dart';

class Step2 extends StatelessWidget {
  final updateIndex;

  const Step2({Key? key, this.updateIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _parent();
  }

  Widget _parent() {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: const [
              Expanded(child: KFormField(label: 'First Name', icon: Icons.person_rounded,)),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: KFormField(label: 'Last Name', icon: Icons.person_rounded),
              )
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          const KFormField(label: 'Email', icon: Icons.email_rounded),
          const SizedBox(
            height: 35,
          ),
          const KFormField(label: 'Phone', icon: Icons.phone_rounded),
          const SizedBox(height: 50),
          KButton(onPressed: updateIndex)
        ],
      ),
    );
  }
}
