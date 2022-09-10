import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/webViewBuilder.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  final String? src;

  const Contact({Key? key, this.src}) : super(key: key);

  static List contactItems = [
    {
      'name': 'Call Us',
      'target': 'phone',
      'icon': Icons.phone_in_talk_rounded,
      'image': false
    },
    {
      'name': 'Send SMS',
      'target': 'sms',
      'icon': Icons.messenger_rounded,
      'image': false
    },
    {'name': 'Email Us', 'target': 'email', 'icon': Icons.mail, 'image': false},
    {
      'name': 'Whatsapp Us',
      'target': 'whatsapp',
      'icon': Image.asset(
        'assets/icons/whatsap_line.png',
        width: 35,
        height: 35,
        color: KColors.kDarkColor,
      ),
      'image': true
    },
    {
      'name': 'Record Message',
      'target': 'record',
      'icon': Image.asset(
        'assets/icons/record_message.png',
        width: 35,
        height: 35,
        color: KColors.kDarkColor,
      ),
      'image': true
    },
    {'name': 'Visit Site', 'target': 'site', 'icon': Icons.tv, 'image': false}
  ];

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  bool _hasCallSupport = false;
  final String _phone = '+233 54 060 9437';

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _textMe(phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _sendMail() async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: "mnnlthmpsn@outlook.com",
    );
    await launchUrl(launchUri);
  }

  Future<void> _sendWhatsapp() async {
    await launchUrl(Uri.parse('whatsapp://send?phone=$_phone'));
  }

  void handleClick(item) {
    if (item['target'] == 'phone' && _hasCallSupport) {
      _makePhoneCall(_phone);
    }
    if (item['target'] == 'sms') {
      _textMe(_phone);
    }
    if (item['target'] == 'email') {
      _sendMail();
    }
    if (item['target'] == 'whatsapp' || item['target'] == 'record') {
      _sendWhatsapp();
    } else {}
  }

  final dynamic htmlData = r"""
    <div class="mapouter">
      <div class="gmap_canvas">
        <iframe width="600" height="500" 
        id="gmap_canvas" 
        src="https://maps.google.com/maps?q=crown%20of%20glory%20assembly&t=&z=13&ie=UTF8&iwloc=&output=embed" 
        frameborder="0" scrolling="no" 
        marginheight="0" marginwidth="0">
        </iframe>
        <a href="https://123movies-to.org">
        </a><br><style>.mapouter{position:relative;text-align:right;height:500px;width:600px;}</style><a href="https://www.embedgooglemap.net">embedgooglemap.net</a><style>.gmap_canvas {overflow:hidden;background:none!important;height:500px;width:600px;}</style></div></div>
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.src == null ? appBar(context) : invisible(),
      body: (SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 56,
              width: double.infinity,
              color: KColors.kLightColor,
              child: Text('Choose an option'),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.white,
                            KColors.kLightColor.withOpacity(.6)
                          ]),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(.1),
                            spreadRadius: 8,
                            blurRadius: 60,
                            offset: Offset(0, 0))
                      ]),
                  child: ListTile(
                      onTap: () => {handleClick(Contact.contactItems[i])},
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * .3),
                          Contact.contactItems[i]['image'] == true
                              ? Contact.contactItems[i]['icon']
                              : Icon(
                                  Contact.contactItems[i]['icon'],
                                  color: KColors.kDarkColor,
                                  size: 30,
                                ),
                          SizedBox(width: 16),
                          Text(
                            Contact.contactItems[i]['name']!,
                            style: const TextStyle(fontSize: 14),
                          )
                        ],
                      )),
                );
              },
              itemCount: Contact.contactItems.length,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * .35,
                width: double.infinity,
                child: WebViewBuilder(url: 'https://pama.vercel.app/map'))
          ],
        ),
      )),
    );
  }

  // @override
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

  PreferredSizeWidget invisible() {
    return AppBar(toolbarHeight: 0);
  }
}
