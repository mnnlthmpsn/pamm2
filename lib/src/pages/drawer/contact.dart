import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/drawer.dart';

class Contact extends StatelessWidget {
  final String? src;

  const Contact({Key? key, this.src = 'contact'}) : super(key: key);

  static List contactItems = [
    {
      'name': 'Call Us',
      'icon': Image.asset(
        'assets/icons/call_us.png',
        width: 50,
        height: 50,
      ),
      'image': true
    },
    {
      'name': 'Text Us',
      'icon': Image.asset(
        'assets/icons/Text.png',
        width: 35,
        height: 35,
      ),
      'image': true
    },
    {
      'name': 'Email Us',
      'icon': Image.asset(
        'assets/icons/mail.png',
        width: 40,
        height: 40,
      ),
      'image': true
    },
    {
      'name': 'Whatsapp Us',
      'icon': Image.asset(
        'assets/icons/whatsapp.png',
        width: 35,
        height: 35,
      ),
      'image': true
    },
    {
      'name': 'Record Message',
      'icon': Image.asset(
        'assets/icons/record_message.png',
        width: 35,
        height: 35,
      ),
      'image': true
    },
    {'name': 'Visit Site', 'icon': Icons.vpn_lock, 'image': false},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Material(
              child: Scaffold(
                backgroundColor: Colors.white,
      appBar: src == 'contact'
            ? appBar(context)
            : AppBar(
                toolbarHeight: 0,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10),
          child: _giveParent(context),
      ),
    )),
        ));
  }

  Widget _giveParent(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Wrap(
        alignment: contactItems.length % 2 == 0
            ? WrapAlignment.center
            : WrapAlignment.start,
        children: contactItems
            .map((testItem) => contactItem(context, testItem))
            .toList(),
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: KColors.kPrimaryColor,
      automaticallyImplyLeading: true,
      title: const Text(
        'Contact Us',
        style: TextStyle(fontSize: 16),
      ),
      elevation: 0,
    );
  }

  Widget contactItem(context, item) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .48,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    backgroundColor: KColors.kLightColor,
                    primary: KColors.kDarkColor),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .40,
                      height: MediaQuery.of(context).size.width * .40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          item['image'] == true
                              ? item['icon']
                              : Icon(
                                  item['icon'],
                                  color: KColors.kPrimaryColor,
                                  size: 35,
                                ),
                          const SizedBox(height: 10),
                          Text(
                            item['name'],
                            style: TextStyle(
                                color: KColors.kDarkColor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ))),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
