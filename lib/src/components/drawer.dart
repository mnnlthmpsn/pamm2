import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pamm2/config.dart';

class kDrawer extends StatelessWidget {
  const kDrawer({Key? key}) : super(key: key);

  static const List<Map<String, dynamic>> menuItems = [
    {
      'title': 'My Account',
      'route': 'account',
      'icon': Icons.person_pin_rounded
    },
    {'title': 'About Us', 'route': 'about', 'icon': Icons.info_outline_rounded},
    {'title': 'Give Online', 'route': 'give', 'icon': Icons.favorite_rounded},
    {
      'title': 'Share Testimony',
      'route': 'testimony',
      'icon': Icons.message_outlined
    },
    {
      'title': 'Contact Us',
      'route': 'contact',
      'icon': Icons.mail_outline_rounded
    },
    {
      'title': 'Social Media',
      'route': 'social-media',
      'icon': Icons.alternate_email_outlined
    },
    {'title': 'Prayer Request', 'route': 'prayer', 'icon': Icons.rate_review},
    {'title': 'Visit Website', 'route': 'website', 'icon': Icons.tv_rounded},
    {'title': 'Share App', 'route': 'share', 'icon': Icons.share_rounded},
    {
      'title': 'Events',
      'route': 'events',
      'icon': Icons.event_available_outlined
    },
    {'title': 'Rate App', 'route': 'rate', 'icon': Icons.star_rate},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: KColors.kPrimaryColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  enableFeedback: true,
                  onTap: (){},
                  leading: Icon(menuItems[index]['icon'], color: Colors.white,),
                  title: Text(menuItems[index]['title'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                );
              }),
        ),
      ),
    );
  }
}

Widget openDrawer() {
  return Builder(
    builder: (BuildContext context) {
      return InkWell(
        enableFeedback: true,
        child: const HeroIcon(HeroIcons.menuAlt3),
        onTap: () => Scaffold.of(context).openDrawer(),
      );
    },
  );
}
