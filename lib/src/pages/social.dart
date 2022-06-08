import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:url_launcher/url_launcher.dart';

class Social extends StatefulWidget {
  const Social({Key? key}) : super(key: key);

  static const socialLinks = [
    { 'title': 'Facebook', 'image': 'assets/icons/facebook.png', 'link': 'https://facebook.com/prophetasantemensah' },
    { 'title': 'Twitter', 'image': 'assets/icons/twitter.png', 'link': 'https://twitter.com/revasantemensah' },
    { 'title': 'Instagram', 'image': 'assets/icons/instagram.png', 'link': 'https://www.instagram.com/prophetasantemensah/' },
    { 'title': 'Youtube', 'image': 'assets/icons/youtube.png', 'link': 'https://www.youtube.com/channel/UCCawkgDRQGkkuOq9iMq75XQ' },
  ];

  @override
  State<Social> createState() => _SocialState();
}

class _SocialState extends State<Social> {

  bool _hasCallSupport = false;
  Future<void>? _launched;
  String _phone = '';

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.kLightColor,
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
        backgroundColor: KColors.kPrimaryColor,
        title: const Text(
          'Social',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ));
  }

  Widget _body() {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black45,
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black45.withOpacity(.95),
                      BlendMode.saturation),
                image: const AssetImage('assets/images/social_image_new.png'),
                fit: BoxFit.fitWidth
              )
            ),
            child: const Text('Like/Follow PAM on', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)),
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
                        ]
                    ),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(.1), spreadRadius: 8, blurRadius: 60, offset: Offset(0, 0))
                    ]
                ),
                child: ListTile(
                  onTap: () => _launchInBrowser(Uri.parse(Social.socialLinks[i]['link']!)),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width * .3),
                        Image.asset(Social.socialLinks[i]['image']!, height: 40),
                        const SizedBox(width: 16),
                        Text(Social.socialLinks[i]['title']!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
                      ],
                    )
                ),
              );
            },
            itemCount: Social.socialLinks.length,
          ),
          const SizedBox(height: 20),
          const Text('Share PAM on', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/icons/face-black.png', height: 30),
              const SizedBox(width: 30),
              Image.asset('assets/icons/tweet_black.png', height: 30),
              const SizedBox(width: 30),
              const Icon(Icons.share, size: 30,)
            ],
          )
        ],
      ),
    );
  }
}
