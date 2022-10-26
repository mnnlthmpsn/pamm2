import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/generated/assets.dart';
import 'package:url_launcher/url_launcher.dart';

class Social extends StatefulWidget {
  const Social({Key? key}) : super(key: key);

  static List<Map<String, String>> socialLinks = [
    {
      'title': 'Facebook',
      'image': Assets.socialFacebook,
      'link': 'https://facebook.com/prophetasantemensah'
    },
    {
      'title': 'Twitter',
      'image': Assets.socialTwitter,
      'link': 'https://twitter.com/revasantemensah'
    },
    {
      'title': 'Tiktok',
      'image': Assets.socialTiktok,
      'link': 'https://www.tiktok.com/@chrisasanteministries'
    },
    {
      'title': 'Youtube',
      'image': Assets.socialYoutube,
      'link': 'https://www.youtube.com/channel/UCCawkgDRQGkkuOq9iMq75XQ'
    },
    {
      'title': 'Instagram',
      'image': Assets.socialInstagram,
      'link': 'https://www.instagram.com/prophetasantemensah/'
    }
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
          'SOCIAL',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ));
  }

  Widget _body() {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          // Container(
          //   color: Colors.red,
          //   height: MediaQuery.of(context).size.height * .13,
          //   width: double.infinity,
          //   child: Image.asset('assets/images/social_med.jpg', fit: BoxFit.cover, alignment: Alignment.center)
          // ),
          Container(
            alignment: Alignment.center,
            height: 56,
            width: double.infinity,
            color: KColors.kLightColor,
            child: const Text('Follow Chris Asante Ministries on'),
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
                    onTap: () => _launchInBrowser(
                        Uri.parse(Social.socialLinks[i]['link']!)),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width * .3),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  Social.socialLinks[i]['title'] == 'Tiktok' || Social.socialLinks[i]['title'] == 'Instagram'
                                      ? 5.0
                                      : 0),
                          child: Image.asset(Social.socialLinks[i]['image']!,
                              height:
                                  Social.socialLinks[i]['title'] == 'Tiktok' ||
                                          Social.socialLinks[i]['title'] ==
                                              'Instagram'
                                      ? 32
                                      : 40,
                              color: KColors.kDarkColor),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          Social.socialLinks[i]['title']!,
                          style: const TextStyle(fontSize: 14),
                        )
                      ],
                    )),
              );
            },
            itemCount: Social.socialLinks.length,
          ),
          const SizedBox(height: 20),
          const Text('Share CAM on',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/icons/faceBlack.png', height: 30),
              const SizedBox(width: 30),
              Image.asset('assets/icons/tweet_black.png', height: 30),
              const SizedBox(width: 30),
              const Icon(
                Icons.share,
                size: 30,
              )
            ],
          ),
          const SizedBox(height: 30)
        ],
      ),
    );
  }
}
