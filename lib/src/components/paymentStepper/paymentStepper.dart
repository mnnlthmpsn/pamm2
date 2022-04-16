import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/paymentStepper/step1.dart';
import 'package:pamm2/src/components/paymentStepper/step2.dart';
import 'package:pamm2/src/components/paymentStepper/step3.dart';

class PaymentStepper extends StatefulWidget {
  const PaymentStepper({Key? key}) : super(key: key);

  @override
  State<PaymentStepper> createState() => _PaymentStepperState();
}

class _PaymentStepperState extends State<PaymentStepper> {
  int activeIndex = 0;
  int activePaymentIndex = 0;

  List<String> titles = ['Choose Amount', 'Information', 'Payment'];
  List<Map<String, dynamic>> payment = [
    {'title': 'MOMO', 'icon': Icons.money},
    {'title': 'CARD', 'icon': Icons.credit_card},
  ];

  _updateIndex(int params) {
    setState(() {
      activeIndex = params;
    });
  }

  @override
  Widget build(BuildContext context) {
    List components = [
      Step1(updateIndex: () => _updateIndex(1)),
      Step2(updateIndex: () => _updateIndex(2)),
      Step3(active: activePaymentIndex)
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            activeIndex != 2 ? _givingText() : const SizedBox.shrink(),
            Container(
                color: KColors.kPrimaryColor,
                padding: EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 12,
                    bottom: activeIndex == 2 ? 0 : 12),
                margin: const EdgeInsets.only(top: 10),
                child: activeIndex != 2
                    ? _tabs()
                    : SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [_tabs(), _paymentTabs()],
                        ),
                      )),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              child: components[activeIndex],
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide.none,
                      left: BorderSide(
                          width: 1, color: Colors.grey.withOpacity(.3)),
                      right: BorderSide(
                          width: 1, color: Colors.grey.withOpacity(.3)),
                      bottom: BorderSide(
                          width: 1, color: Colors.grey.withOpacity(.3)))),
            ),
            // giving_thanks_text
            activeIndex == 1 ? const SizedBox.shrink() : _givingThanksText()
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        activeIndex != 0
            ? IconButton(
                onPressed: () {
                  setState(() {
                    activeIndex = activeIndex - 1;
                  });
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ))
            : const SizedBox.shrink(),
        Row(
          children: [
            Text(titles[activeIndex],
                style: const TextStyle(fontSize: 18, color: Colors.white)),
            const SizedBox(width: 4),
            Row(
                children:
                    List.generate(3, (index) => _indicator(index)).toList())
          ],
        ),
        activeIndex != 2
            ? IconButton(
                onPressed: () {
                  setState(() {
                    activeIndex = activeIndex + 1;
                  });
                },
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                ))
            : const SizedBox.shrink()
      ],
    );
  }

  Widget _paymentTabs() {
    return Row(children: List.generate(2, (index) => _payment(index)));
  }

  Widget _payment(int index) {
    return GestureDetector(
      onTap: () => setState(() => activePaymentIndex = index),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 1.0),
        child: Container(
          width: MediaQuery.of(context).size.width * .4,
          child: Center(
              child: Column(
            children: [
              Icon(
                payment[index]['icon'],
                color: activePaymentIndex == index
                    ? Colors.white
                    : Colors.white.withOpacity(.5),
                size: 16,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                payment[index]['title'],
                style: TextStyle(
                    color: activePaymentIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(.5),
                    fontSize: 12),
              )
            ],
          )),
          decoration: BoxDecoration(
              border: Border(
                  bottom: activePaymentIndex == index
                      ? const BorderSide(width: 3, color: Colors.white)
                      : BorderSide.none)),
        ),
      ),
    );
  }

  Widget _indicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
          color: activeIndex == index
              ? Colors.white.withOpacity(.5)
              : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
              style:
                  activeIndex == index ? BorderStyle.none : BorderStyle.solid,
              color: Colors.white.withOpacity(.5))),
    );
  }

  Widget _givingText() {
    return Column(
      children: [
        const SizedBox(height: 60),
        Text('GIVE YOUR DONATION',
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(color: KColors.kDarkColor)),
        const SizedBox(
          height: 30,
        ),
        const Text(
          'To give your DONATION, simply fill in the details below. You can check-out by Debit/Credit Card or Momo',
          textAlign: TextAlign.center, style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 60,
        )
      ],
    );
  }

  Widget _givingThanksText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(
            height: 30,
          ),
          Text(
              'What a blessing to hear from you, and I\'m thankful for your gift planted to God through this ministry', style: TextStyle(fontSize: 16),),
          SizedBox(
            height: 20,
          ),
          Text(
              'We\'re promised in God\'s word that when we sow unto Him in Faith, we can believe for a multiplied harvest of blessing on our seed (Luke 6:38)', style: TextStyle(fontSize: 16),),
          SizedBox(
            height: 20,
          ),
          Text('God is faithful... so be expecting miracles', style: TextStyle(fontSize: 16),),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
